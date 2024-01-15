// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/dialogs.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/permissions.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/pop_up_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/toast.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_controller.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_inner_text.dart';

/// @nodoc
class ZegoLiveConnectManager {
  ZegoLiveConnectManager({
    required this.config,
    required this.seatManager,
    required this.popUpManager,
    required this.prebuiltController,
    required this.innerText,
    required this.kickOutNotifier,
    required this.roomData ,
  }) {
  }
  final EnterRoomModel roomData ;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;
  final ZegoLiveSeatManager seatManager;
  final ZegoPopUpManager popUpManager;
  final ZegoLiveAudioRoomController? prebuiltController;
  final ZegoInnerText innerText;
  final ValueNotifier<bool> kickOutNotifier;
  static  BuildContext Function()? contextQuery ;

  /// current audience connection state
  final audienceLocalConnectStateNotifier =
      ValueNotifier<ConnectState>(ConnectState.idle);

  /// audiences which requesting to take seat
  final audiencesRequestingTakeSeatNotifier =
      ValueNotifier<List<ZegoUIKitUser>>([]);

  /// audiences which host invite to take seat
  final List<String> _audienceIDsInvitedTakeSeatByHost = [];

  bool _initialized = false;

  ///  invite dialog's visibility of audience
  bool _isInvitedTakeSeatDlgVisible = false;

  final List<StreamSubscription<dynamic>?> _subscriptions = [];

  void init() {
    if (_initialized) {
      ZegoLoggerService.logInfo(
        'had already init',
        tag: 'live audio',
        subTag: 'seat manager',
      );
      return;
    }

    _initialized = true;

    ZegoLoggerService.logInfo(
      'init',
      tag: 'live audio',
      subTag: 'connect manager',
    );

    _subscriptions
        .add(ZegoUIKit().getUserLeaveStream().listen(onUserListLeaveUpdated));
  }

  void uninit() {
    if (!_initialized) {
      ZegoLoggerService.logInfo(
        'not init before',
        tag: 'live audio',
        subTag: 'connect manager',
      );
    }

    _initialized = false;

    ZegoLoggerService.logInfo(
      'uninit',
      tag: 'live audio',
      subTag: 'connect manager',
    );

    audienceLocalConnectStateNotifier.value = ConnectState.idle;
    audiencesRequestingTakeSeatNotifier.value = [];
    _isInvitedTakeSeatDlgVisible = false;
    _audienceIDsInvitedTakeSeatByHost.clear();

    for (final subscription in _subscriptions) {
      subscription?.cancel();
    }
  }

  void removeRequestCoHostUsers(ZegoUIKitUser targetUser) {
    audiencesRequestingTakeSeatNotifier.value =
        List<ZegoUIKitUser>.from(audiencesRequestingTakeSeatNotifier.value)
          ..removeWhere((user) => user.id == targetUser.id);
  }

  void updateAudienceConnectState(ConnectState state) {
    if (state == audienceLocalConnectStateNotifier.value) {
      ZegoLoggerService.logInfo(
        'audience connect state is same: $state',
        tag: 'live audio',
        subTag: 'connect manager',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'update audience connect state: $state',
      tag: 'live audio',
      subTag: 'connect manager',
    );

    switch (state) {
      case ConnectState.idle:

        ZegoUIKit().turnMicrophoneOn(false);

        /// hide invite join take seat dialog
        if (_isInvitedTakeSeatDlgVisible) {
          _isInvitedTakeSeatDlgVisible = false;
          Navigator.of(
            contextQuery!.call(),
            rootNavigator: config.rootNavigator,
          ).pop();
        }

        break;
      case ConnectState.connecting:
        break;
      case ConnectState.connected:
        ZegoUIKit().turnMicrophoneOn(true);
        break;
    }

    audienceLocalConnectStateNotifier.value = state;
  }

  // void onSeatLockedChanged(bool isLocked) {
  //   ZegoLoggerService.logInfo(
  //     'on seat locked changed: $isLocked',
  //     tag: 'live audio',
  //     subTag: 'connect manager',
  //   );
  //
  //   /// cancel if still requesting when room locked/unlocked
  //   audienceCancelTakeSeatRequest();
  //
  //   if (!isLocked) {
  //     /// hide invite take seat dialog
  //     if (_isInvitedTakeSeatDlgVisible) {
  //       _isInvitedTakeSeatDlgVisible = false;
  //       Navigator.of(
  //         contextQuery!.call(),
  //         rootNavigator: config.rootNavigator,
  //       ).pop();
  //     }
  //   }
  // }

  void hostCancelTakeSeatInvitation() {
    ZegoLoggerService.logInfo(
      'host cancel take seat invitation',
      tag: 'live audio',
      subTag: 'connect manager',
    );

    _audienceIDsInvitedTakeSeatByHost
      ..forEach((audienceID) {
        ZegoUIKit().getSignalingPlugin().cancelInvitation(
          invitees: [audienceID],
          data: '',
        );
      })
      ..clear();
  }

  Future<bool> audienceCancelTakeSeatRequest() async {
    ZegoLoggerService.logInfo(
      'audience cancel take seat request, connect state: ${audienceLocalConnectStateNotifier.value}',
      tag: 'live audio',
      subTag: 'connect manager',
    );

    if (audienceLocalConnectStateNotifier.value == ConnectState.connecting) {
      return ZegoUIKit()
          .getSignalingPlugin()
          .cancelInvitation(
            invitees: seatManager.hostsNotifier.value,
            data: '',
          )
          .then((ZegoSignalingPluginCancelInvitationResult result) {
        updateAudienceConnectState(ConnectState.idle);

        ZegoLoggerService.logInfo(
          'audience cancel take seat request finished, '
          'code:${result.error?.code}, '
          'message:${result.error?.message}, '
          'errorInvitees:${result.errorInvitees}',
          tag: 'audio room',
          subTag: 'controller',
        );

        return result.error?.code.isNotEmpty ?? true;
      });
    }

    return true;
  }

  void onUserListLeaveUpdated(List<ZegoUIKitUser> users) {
    ZegoLoggerService.logInfo(
      'users leave, ${users.map((e) => e.toString()).toList()}',
      tag: 'live audio',
      subTag: 'connect manager',
    );

    final userIDs = users.map((e) => e.id).toList();

    _audienceIDsInvitedTakeSeatByHost
        .removeWhere((userID) => userIDs.contains(userID));

    audiencesRequestingTakeSeatNotifier.value =
        List<ZegoUIKitUser>.from(audiencesRequestingTakeSeatNotifier.value)
          ..removeWhere((user) => userIDs.contains(user.id));
  }
}
