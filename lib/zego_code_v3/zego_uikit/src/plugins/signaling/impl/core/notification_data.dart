// Dart imports:

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:

/// @nodoc
mixin ZegoSignalingPluginCoreNotificationData {
  bool notifyWhenAppIsInTheBackgroundOrQuit = false;

  /// enable notification
  Future<ZegoSignalingPluginEnableNotifyResult>
      enableNotifyWhenAppRunningInBackgroundOrQuit(
    bool enabled, {
    bool isIOSSandboxEnvironment = false,
    bool enableIOSVoIP = true,
    ZegoSignalingPluginMultiCertificate certificateIndex =
        ZegoSignalingPluginMultiCertificate.firstCertificate,
    String appName = '',
    String androidChannelID = '',
    String androidChannelName = '',
    String androidSound = '',
  }) {
    ZegoLoggerService.logInfo(
      'enable notify when app is in the background or quit: $enabled',
      tag: 'uikit',
      subTag: 'signaling notification data',
    );
    notifyWhenAppIsInTheBackgroundOrQuit = enabled;

    return ZegoPluginAdapter()
        .signalingPlugin!
        .enableNotifyWhenAppRunningInBackgroundOrQuit(
          isIOSSandboxEnvironment: isIOSSandboxEnvironment,
          enableIOSVoIP: enableIOSVoIP,
          certificateIndex: certificateIndex,
          appName: appName,
          androidChannelID: androidChannelID,
          androidChannelName: androidChannelName,
          androidSound: androidSound,
        );
  }
}
