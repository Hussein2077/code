// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart' show  kIsWeb;
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/internal/zego_signaling_plugin_event_center.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/internal/zego_signaling_plugin_core.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/log/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/zego_signaling_plugin_background_message.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/zego_signaling_plugin_callkit.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';
import 'package:zego_zim/zego_zim.dart';
import 'package:zego_zpns/zego_zpns.dart';

// Project imports:






export 'package:zego_zim/zego_zim.dart' hide ZIMEventHandler;

part 'src/zego_signaling_plugin_invitation.dart';

part 'src/zego_signaling_plugin_message.dart';

part 'src/zego_signaling_plugin_notification.dart';

part 'src/zego_signaling_plugin_room.dart';

part 'src/zego_signaling_plugin_user.dart';

/// @nodoc
class ZegoUIKitSignalingPlugin
    with
        ZegoSignalingPluginRoomAPIImpl,
        ZegoSignalingPluginRoomEventImpl,
        ZegoSignalingPluginInvitationAPIImpl,
        ZegoSignalingPluginInvitationEventImpl,
        ZegoSignalingPluginUserAPIImpl,
        ZegoSignalingPluginUserEventImpl,
        ZegoSignalingPluginNotificationAPIImpl,
        ZegoSignalingPluginNotificationEventImpl,
        ZegoSignalingPluginMessageAPIImpl,
        ZegoSignalingPluginMessageEventImpl,
        ZegoSignalingPluginBackgroundMessageAPIImpl,
        ZegoSignalingPluginBackgroundMessageEventImpl,
        ZegoSignalingPluginCallKitAPIImpl,
        ZegoSignalingPluginCallKitEventImpl,
        IZegoUIKitPlugin
    implements ZegoSignalingPluginInterface {
  ZegoSignalingPluginEventCenter get eventCenter =>
      ZegoSignalingPluginCore().eventCenter;

  factory ZegoUIKitSignalingPlugin() => instance;

  ZegoUIKitSignalingPlugin._();

  static final ZegoUIKitSignalingPlugin instance = ZegoUIKitSignalingPlugin._();

  @override
  ZegoUIKitPluginType getPluginType() => ZegoUIKitPluginType.signaling;

  @override
  Future<String> getVersion() async {
    final zimVersion = await ZIM.getVersion();
    const signalingVersion = 'zego_uikit_signaling_plugin: 2.5.0;';
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final zpnsVersion = await ZPNs.getVersion();
      return '$signalingVersion zim:$zimVersion; zpns:$zpnsVersion;';
    } else {
      return '$signalingVersion zim:$zimVersion;';
    }
  }

  @override
  Future<void> init({required int appID, String appSign = ''}) async {
    await ZegoSignalingLoggerService().initLog();

    ZegoSignalingLoggerService.logInfo(
      'create ZIM',
      tag: 'signaling',
      subTag: 'init',
    );

    if (null != ZIM.getInstance()) {
      ZegoSignalingLoggerService.logInfo(
        'ZIM is create before',
        tag: 'signaling',
        subTag: 'init',
      );

      return;
    }

    ZIM.create(ZIMAppConfig()
      ..appID = appID
      ..appSign = appSign);
  }

  @override
  Future<void> uninit() async {
    ZegoSignalingLoggerService.logInfo(
      'destroy ZIM',
      tag: 'signaling',
      subTag: 'init',
    );

    ZIM.getInstance()?.destroy();
  }

  @override
  Stream<ZegoSignalingPluginErrorEvent> getErrorEventStream() {
    return ZegoSignalingPluginCore().eventCenter.errorEvent.stream;
  }

  @override
  Stream<ZegoSignalingPluginInvitationUserStateChangedEvent> getInvitationUserStateChangedEventStream() {
    // TODO: implement getInvitationUserStateChangedEventStream
    throw UnimplementedError();
  }

  @override
  Future<void> activeAppToForeground() {
    // TODO: implement activeAppToForeground
    throw UnimplementedError();
  }

  @override
  Future<void> addLocalNotification(ZegoSignalingPluginOutgoingNotificationConfig config) {
    // TODO: implement addLocalNotification
    throw UnimplementedError();
  }

  @override
  Future<bool> checkAppRunning() {
    // TODO: implement checkAppRunning
    throw UnimplementedError();
  }

  @override
  Future<void> createNotificationChannel(ZegoSignalingPluginOutgoingNotificationChannelConfig config) {
    // TODO: implement createNotificationChannel
    throw UnimplementedError();
  }

  @override
  Future<void> dismissAllNotifications() {
    // TODO: implement dismissAllNotifications
    throw UnimplementedError();
  }

  @override
  Stream<ZegoSignalingError> getErrorStream() {
    // TODO: implement getErrorStream
    throw UnimplementedError();
  }

  @override
  Future<void> reportCallEnded(CXCallEndedReason endedReason, UUID uuid) {
    // TODO: implement reportCallEnded
    throw UnimplementedError();
  }

  @override
  Future<void> requestDismissKeyguard() {
    // TODO: implement requestDismissKeyguard
    throw UnimplementedError();
  }
}
