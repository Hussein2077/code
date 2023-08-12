// Dart imports:
import 'dart:async';
import 'dart:convert';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/plugins/signaling/impl/core/core.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import '../../../../../zego_uikit.dart';

typedef InvitationID = String;

enum InvitationState { error, waiting, accept, refuse, cancel, timeout }

class InvitationUser {
  InvitationUser({required this.userID, required this.state});

  String userID;
  InvitationState state;

  @override
  String toString() {
    return 'userid :$userID, state:$state';
  }
}

class InvitationData {
  InvitationData({
    required this.id,
    required this.inviterID,
    required this.invitees,
    required this.type,
    required this.data,
  });

  String id; // invitation ID
  String inviterID;
  List<InvitationUser> invitees;
  int type;
  String data;

  @override
  String toString() {
    return 'id:$id, type:$type, inviter id:$inviterID, '
        'invitees:${invitees.map((e) => e.toString())}, '
        'data:$data';
  }
}

mixin ZegoSignalingPluginCoreInvitationData {
  String? get _loginUser =>
      ZegoSignalingPluginCore.shared.coreData.currentUserID;

  Map<InvitationID, InvitationData> invitationMap = {};

  void addInvitationData(InvitationData invitationData) {
    ZegoLoggerService.logInfo(
      'add invitation data $invitationData',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );
    invitationMap[invitationData.id] = invitationData;
  }

  InvitationData? removeInvitationData(String invitationID) {
    ZegoLoggerService.logInfo(
      'remove invitation data, invitationID: $invitationID',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );
    return invitationMap.remove(invitationID);
  }

  InvitationUser? getInvitee(String invitationID, String userID) {
    for (final invitee
        in invitationMap[invitationID]?.invitees ?? <InvitationUser>[]) {
      if (invitee.userID == userID) {
        return invitee;
      }
    }

    return null;
  }

  String queryInvitationIDByInviterID(String inviterID) {
    for (final invitationData in invitationMap.values) {
      if (invitationData.inviterID == inviterID) {
        return invitationData.id;
      }
    }

    return '';
  }

  String queryInvitationIDByInvitees(List<String> invitees) {
    for (final invitationData in invitationMap.values) {
      var querySuccess = 0;
      for (final targetInvitee in invitees) {
        if (invitationData.invitees
            .any((element) => element.userID == targetInvitee)) {
          querySuccess++;
        } else {
          break;
        }
      }
      if (querySuccess == invitees.length) {
        return invitationData.id;
      }
    }
    return '';
  }

  InvitationData? removeIfAllInviteesDone(String invitationID) {
    var isDone = true;
    for (final invitee
        in invitationMap[invitationID]?.invitees ?? <InvitationUser>[]) {
      if (invitee.state == InvitationState.waiting) {
        isDone = false;
        break;
      }
    }

    if (isDone) {
      return removeInvitationData(invitationID);
    }
    return invitationMap[invitationID];
  }

  void clearInvitationData() {
    invitationMap = {};
  }

  /// invite
  Future<ZegoSignalingPluginSendInvitationResult> invite({
    required int type,
    required List<String> invitees,
    required int timeout,
    String zimExtendedData = '',
    required String kitData,
    ZegoSignalingPluginNotificationConfig? notificationConfig,
  }) async {
    return ZegoPluginAdapter()
        .signalingPlugin!
        .sendInvitation(
          invitees: invitees,
          timeout: timeout,
          extendedData: zimExtendedData,
          notificationConfig: notificationConfig,
        )
        .then((result) {
      if (result.error == null) {
        ZegoLoggerService.logInfo(
          'send invitation done, invitationID:${result.invitationID}',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );

        final invitationData = InvitationData(
          id: result.invitationID,
          inviterID: _loginUser!,
          invitees: invitees
              .map((inviteeID) => InvitationUser(
                    userID: inviteeID,
                    state: InvitationState.waiting,
                  ))
              .toList(),
          type: type,
          data: kitData,
        );
        addInvitationData(invitationData);

        if (result.errorInvitees.isNotEmpty) {
          var errorMessage = '';
          result.errorInvitees.forEach((id, state) {
            errorMessage += '$id:${state.name};';
            ZegoLoggerService.logInfo(
              'invite error, $errorMessage',
              tag: 'uikit',
              subTag: 'signaling invitation data',
            );
          });

          final errorUserIDs = result.errorInvitees.keys.toList();
          for (final invitee in invitationData.invitees) {
            if (errorUserIDs.contains(invitee.userID)) {
              invitee.state = InvitationState.error;
            }
          }
          removeIfAllInviteesDone(result.invitationID);
          return ZegoSignalingPluginSendInvitationResult(
            invitationID: result.invitationID,
            errorInvitees: result.errorInvitees,
          );
        } else {
          ZegoLoggerService.logInfo(
            'invite success, invitationID:${result.invitationID}',
            tag: 'uikit',
            subTag: 'signaling invitation data',
          );

          return result;
        }
      } else {
        ZegoLoggerService.logInfo(
          'send invitation failed, error: ${result.error}',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );
      }
      return result;
    });
  }

  /// cancel
  Future<ZegoSignalingPluginCancelInvitationResult> cancel(
      List<String> invitees, String invitationID, String extendedData) async {
    return ZegoPluginAdapter()
        .signalingPlugin!
        .cancelInvitation(
          invitationID: invitationID,
          invitees: invitees,
          extendedData: extendedData,
        )
        .then((result) {
      if (result.error == null) {
        for (final invitee
            in invitationMap[invitationID]?.invitees ?? <InvitationUser>[]) {
          final isCancelUser = invitees.contains(invitee.userID);
          final isCancelError = result.errorInvitees.contains(invitee.userID);
          if (isCancelUser && !isCancelError) {
            invitee.state = InvitationState.cancel;
          } else {
            invitee.state = InvitationState.error;
          }
        }
        removeIfAllInviteesDone(invitationID);

        if (result.errorInvitees.isNotEmpty) {
          for (final element in result.errorInvitees) {
            ZegoLoggerService.logInfo(
              'cancel invitation error, invitationID:$invitationID, invitee id:$element',
              tag: 'uikit',
              subTag: 'signaling invitation data',
            );
          }
        } else {
          ZegoLoggerService.logInfo(
            'cancel invitation done, invitationID:$invitationID',
            tag: 'uikit',
            subTag: 'signaling invitation data',
          );
        }
      } else {
        ZegoLoggerService.logInfo(
          'cancel invitation failed, error:${result.error}',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );
      }
      return result;
    });
  }

  /// accept
  Future<ZegoSignalingPluginResponseInvitationResult> accept(
      String invitationID, String extendedData) async {
    removeInvitationData(invitationID);

    return ZegoPluginAdapter()
        .signalingPlugin!
        .acceptInvitation(
          invitationID: invitationID,
          extendedData: extendedData,
        )
        .then((result) {
      if (result.error == null) {
        ZegoLoggerService.logInfo(
          'accept invitation done, invitationID:$invitationID',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );
      } else {
        ZegoLoggerService.logInfo(
          'accept invitation failed, error: ${result.error}',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );
      }
      return result;
    });
  }

  /// reject
  Future<ZegoSignalingPluginResponseInvitationResult> reject(
      String invitationID, String extendedData) async {
    removeInvitationData(invitationID);

    return ZegoPluginAdapter()
        .signalingPlugin!
        .refuseInvitation(
          invitationID: invitationID,
          extendedData: extendedData,
        )
        .then((result) {
      if (result.error == null) {
        ZegoLoggerService.logInfo(
          'reject invitation done, invitationID:$invitationID',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );
      } else {
        ZegoLoggerService.logInfo(
          'reject invitation failed, error: ${result.error}',
          tag: 'uikit',
          subTag: 'signaling invitation data',
        );
      }
      return result;
    });
  }

  // ------- events ------
  StreamController<Map<String, dynamic>> streamCtrlInvitationReceived =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> streamCtrlInvitationTimeout =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> streamCtrlInvitationResponseTimeout =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> streamCtrlInvitationAccepted =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> streamCtrlInvitationRefused =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> streamCtrlInvitationCanceled =
      StreamController<Map<String, dynamic>>.broadcast();

  /// on incoming invitation received
  void onIncomingInvitationReceived(
      ZegoSignalingPluginIncomingInvitationReceivedEvent event) {
    ZegoLoggerService.logInfo(
      'onIncomingInvitationReceived, $event',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );

    final extendedMap = jsonDecode(event.extendedData) as Map<String, dynamic>;

    final invitationData = InvitationData(
      id: event.invitationID,
      inviterID: event.inviterID,
      invitees: [
        InvitationUser(
          userID: _loginUser!,
          state: InvitationState.waiting,
        )
      ],
      type: extendedMap['type'] as int,
      data: extendedMap['data'] as String,
    );
    if (invitationMap.containsKey(invitationData.id)) {
      ZegoLoggerService.logInfo(
        'call id ${invitationData.id} is exist before',
        tag: 'signal',
        subTag: 'invitation data',
      );

      return;
    }

    addInvitationData(invitationData);

    streamCtrlInvitationReceived.add({
      'invitation_id': event.invitationID,
      'data': extendedMap['data'] as String,
      'type': extendedMap['type'] as int,
      'inviter': ZegoUIKitUser(
          id: event.inviterID, name: extendedMap['inviter_name'] as String),
      'timeout_second': event.timeoutSecond,
    });
  }

  void onIncomingInvitationCancelled(
      ZegoSignalingPluginIncomingInvitationCancelledEvent event) {
    //  inviter extendedData
    ZegoLoggerService.logInfo(
      'onIncomingInvitationCancelled, $event',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );

    final invitationData = removeInvitationData(event.invitationID);

    streamCtrlInvitationCanceled.add({
      'invitation_id': event.invitationID,
      'data': event.extendedData,
      'type': invitationData?.type ?? 0,
      'inviter': ZegoUIKitUser(id: event.inviterID, name: ''),
    });
  }

  /// on call invitation accepted
  void onOutgoingInvitationAccepted(
      ZegoSignalingPluginOutgoingInvitationAcceptedEvent event) {
    //  inviter extendedData
    ZegoLoggerService.logInfo(
      'onOutgoingInvitationAccepted, $event',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );

    getInvitee(event.invitationID, event.inviteeID)?.state =
        InvitationState.accept;

    final invitationData = removeInvitationData(event.invitationID);

    streamCtrlInvitationAccepted.add({
      'invitation_id': event.invitationID,
      'data': event.extendedData,
      'type': invitationData?.type ?? 0,
      'invitee': ZegoUIKitUser(id: event.inviteeID, name: ''),
    });
  }

  /// on call invitation rejected
  void onOutgoingInvitationRejected(
      ZegoSignalingPluginOutgoingInvitationRejectedEvent event) {
    //  inviter extendedData
    ZegoLoggerService.logInfo(
      'onOutgoingInvitationRejected, $event',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );

    getInvitee(event.invitationID, event.inviteeID)?.state =
        InvitationState.refuse;

    final invitationData = removeIfAllInviteesDone(event.invitationID);

    streamCtrlInvitationRefused.add({
      'invitation_id': event.invitationID,
      'data': event.extendedData,
      'type': invitationData?.type ?? 0,
      'invitee': ZegoUIKitUser(id: event.inviteeID, name: ''),
    });
  }

  /// on call invitation timeout
  void onIncomingInvitationTimeout(
      ZegoSignalingPluginIncomingInvitationTimeoutEvent event) {
    ZegoLoggerService.logInfo(
      'onIncomingInvitationTimeout, $event',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );

    final invitationData = removeInvitationData(event.invitationID);

    streamCtrlInvitationTimeout.add({
      'invitation_id': event.invitationID,
      'data': invitationData?.data ?? '',
      'type': invitationData?.type ?? 0,
      'inviter': ZegoUIKitUser(id: invitationData?.inviterID ?? '', name: ''),
    });
  }

  /// on call invitation answered timeout
  void onOutgoingInvitationTimeout(
      ZegoSignalingPluginOutgoingInvitationTimeoutEvent event) {
    ZegoLoggerService.logInfo(
      'onOutgoingInvitationTimeout, $event',
      tag: 'uikit',
      subTag: 'signaling invitation data',
    );

    for (final invitee
        in invitationMap[event.invitationID]?.invitees ?? <InvitationUser>[]) {
      if (event.invitees.contains(invitee.userID)) {
        invitee.state = InvitationState.timeout;
      }
    }

    final invitationData = removeIfAllInviteesDone(event.invitationID);

    streamCtrlInvitationResponseTimeout.add({
      'invitation_id': event.invitationID,
      'type': invitationData?.type ?? 0,
      'data': invitationData?.data ?? '',
      'invitees': event.invitees
          .map((inviteeID) => ZegoUIKitUser(id: inviteeID, name: ''))
          .toList(),
    });
  }
}
