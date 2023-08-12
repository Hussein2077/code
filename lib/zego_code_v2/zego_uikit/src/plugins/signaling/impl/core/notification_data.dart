// Dart imports:

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';

import '../../../../services/services.dart';

mixin ZegoSignalingPluginCoreNotificationData {
  bool notifyWhenAppIsInTheBackgroundOrQuit = false;

  /// enable notification
  Future<ZegoSignalingPluginEnableNotifyResult>
      enableNotifyWhenAppRunningInBackgroundOrQuit(
    bool enabled, {
    bool isIOSSandboxEnvironment = false,
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
        );
  }
}
