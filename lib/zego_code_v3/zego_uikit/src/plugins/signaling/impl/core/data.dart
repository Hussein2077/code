// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/core/event.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/core/invitation_data.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/core/notification_data.dart';

/// @nodoc
class ZegoSignalingPluginCoreData
    with
        ZegoSignalingPluginCoreInvitationData,
        ZegoSignalingPluginCoreNotificationData,
        ZegoSignalingPluginCoreEvent {
  bool inited = false;
  String? currentUserID;
  String? currentUserName;
  String? currentRoomID;
  String? currentRoomName;

  /// create engine
  Future<void> create({required int appID, String appSign = ''}) async {
    if (ZegoPluginAdapter().signalingPlugin == null) {
      return;
    }

    if (inited) {
      ZegoLoggerService.logInfo(
        'has created.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );

      return;
    }

    await ZegoPluginAdapter().signalingPlugin!.init(
          appID: appID,
          appSign: appSign,
        );
    inited = true;

    ZegoLoggerService.logInfo(
      'create, appID:$appID',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
  }

  /// destroy engine
  Future<void> destroy({bool forceDestroy = false}) async {
    if (ZegoPluginAdapter().signalingPlugin == null) {
      ZegoLoggerService.logInfo(
        'signaling plugin is null.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return;
    }

    if (!inited) {
      ZegoLoggerService.logInfo(
        'is not created.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return;
    }

    if (forceDestroy) {
      ZegoLoggerService.logInfo(
        'force destroy signaling plugin',
        tag: 'uikit',
        subTag: 'signaling core data',
      );

      ZegoPluginAdapter().signalingPlugin!.uninit();
    }

    inited = false;
    ZegoLoggerService.logInfo(
      'destroy.',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
    clear();
  }

  Future<void> activeAudioByCallKit() async {
    ZegoLoggerService.logInfo(
      'activeAudioByCallKit.',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
    ZegoPluginAdapter().signalingPlugin!.activeAudioByCallKit();
  }

  /// login
  Future<bool> login(String id, String name) async {
    if (ZegoPluginAdapter().signalingPlugin == null) {
      return false;
    }

    if (!inited) {
      ZegoLoggerService.logInfo(
        'is not created.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return false;
    }

    if (null != currentUserID) {
      if (currentUserID != id || currentUserName != name) {
        ZegoLoggerService.logError(
          'login exist before, and not same, auto logout...',
          tag: 'uikit',
          subTag: 'signaling core data',
        );
        await logout();
      } else {
        ZegoLoggerService.logError(
          'login exist before, and same, not need login...',
          tag: 'uikit',
          subTag: 'signaling core data',
        );
        return true;
      }
    }

    ZegoLoggerService.logInfo(
      'login request, user id:$id, user name:$name',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
    currentUserID = id;
    currentUserName = name;

    ZegoLoggerService.logInfo(
      'ready to login.',
      tag: 'uikit',
      subTag: 'signaling core data',
    );

    final pluginResult = await ZegoPluginAdapter()
        .signalingPlugin!
        .connectUser(id: id, name: name);

    if (pluginResult.error == null) {
      ZegoLoggerService.logInfo(
        'login success',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
    } else {
      ZegoLoggerService.logInfo(
        'login error, ${pluginResult.error}',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
    }

    return pluginResult.error == null;
  }

  /// logout
  Future<void> logout() async {
    if (ZegoPluginAdapter().signalingPlugin == null) return;
    ZegoLoggerService.logInfo(
      'user logout',
      tag: 'uikit',
      subTag: 'signaling core data',
    );

    currentUserID = null;
    currentUserName = null;

    final pluginResult =
        await ZegoPluginAdapter().signalingPlugin!.disconnectUser();

    if (pluginResult.timeout) {
      ZegoLoggerService.logInfo(
        'logout waitForDisconnect timeout',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
    } else {
      ZegoLoggerService.logInfo(
        'logout success',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
    }

    clear();
    ZegoLoggerService.logInfo(
      'logout.',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
  }

  /// join room
  Future<ZegoSignalingPluginJoinRoomResult> joinRoom(
      String roomID, String roomName) async {
    if (!inited) {
      ZegoLoggerService.logInfo(
        'is not created.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return ZegoSignalingPluginJoinRoomResult(
        error: PlatformException(code: '-1', message: 'zim is not created.'),
      );
    }
    if (ZegoPluginAdapter().signalingPlugin == null) {
      return ZegoSignalingPluginJoinRoomResult(
        error: PlatformException(code: '-2', message: 'signaling is null'),
      );
    }

    if (currentRoomID != null) {
      ZegoLoggerService.logInfo(
        'room has login.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return ZegoSignalingPluginJoinRoomResult(
        error: PlatformException(code: '-3', message: 'room has login.'),
      );
    }

    currentRoomID = roomID;
    currentRoomName = roomName;

    ZegoLoggerService.logInfo(
      'join room, room id:"$roomID", room name:$roomName',
      tag: 'uikit',
      subTag: 'signaling core data',
    );

    final pluginResult = await ZegoPluginAdapter()
        .signalingPlugin!
        .joinRoom(roomID: roomID, roomName: roomName);

    if (pluginResult.error == null) {
      ZegoLoggerService.logInfo(
        'join room success',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
    } else {
      ZegoLoggerService.logInfo(
        'exception on join room, ${pluginResult.error}',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      currentRoomID = null;
      currentRoomName = null;
    }
    return pluginResult;
  }

  /// leave room
  Future<void> leaveRoom() async {
    if (ZegoPluginAdapter().signalingPlugin == null) return;
    if (!inited) {
      ZegoLoggerService.logInfo(
        'is not created.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return;
    }

    if (currentRoomID == null) {
      ZegoLoggerService.logInfo(
        'room has not login.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'ready to leave room ${currentRoomID!}',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
    final pluginResult = await ZegoPluginAdapter()
        .signalingPlugin!
        .leaveRoom(roomID: currentRoomID!);

    if (pluginResult.error == null) {
      ZegoLoggerService.logInfo(
        'leave room success',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      currentRoomID = null;
    } else {
      ZegoLoggerService.logInfo(
        'leave room failed with ${pluginResult.error}',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
    }
  }

  /// clear
  void clear() {
    ZegoLoggerService.logInfo(
      'clear',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
    clearInvitationData();

    currentUserID = null;
    currentUserName = null;
    currentRoomID = null;
    currentRoomName = null;
  }

  ///  on error
  void onError(ZegoSignalingPluginErrorEvent event) {
    ZegoLoggerService.logInfo(
      'zim error, $event',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
  }

  /// on connection state changed
  void onConnectionStateChanged(
      ZegoSignalingPluginConnectionStateChangedEvent event) {
    ZegoLoggerService.logInfo(
      'connection state changed, $event',
      tag: 'uikit',
      subTag: 'signaling core data',
    );

    if (event.state == ZegoSignalingPluginConnectionState.disconnected) {
      ZegoLoggerService.logInfo(
        'disconnected, auto logout',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      // TODO 这个逻辑怎么搞 zimkit一起用的话估计是有问题的
      logout();
    }
  }

  void onNotificationArrived(
      ZegoSignalingPluginNotificationArrivedEvent event) {
    ZegoLoggerService.logInfo(
      'notification arrived, $event',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
  }

  void onNotificationClicked(
      ZegoSignalingPluginNotificationClickedEvent event) {
    ZegoLoggerService.logInfo(
      'notification clicked, $event',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
  }

  void onNotificationRegistered(
      ZegoSignalingPluginNotificationRegisteredEvent event) {
    ZegoLoggerService.logInfo(
      'notification registered, $event',
      tag: 'uikit',
      subTag: 'signaling core data',
    );
  }

  /// on room state changed
  void onRoomStateChanged(ZegoSignalingPluginRoomStateChangedEvent event) {
    ZegoLoggerService.logInfo(
      'room state changed, $event',
      tag: 'uikit',
      subTag: 'signaling core data',
    );

    if (event.state == ZegoSignalingPluginRoomState.disconnected) {
      ZegoLoggerService.logInfo(
        'room has been disconnect.',
        tag: 'uikit',
        subTag: 'signaling core data',
      );
      currentRoomID = null;
      currentRoomName = null;
    }
  }
}
