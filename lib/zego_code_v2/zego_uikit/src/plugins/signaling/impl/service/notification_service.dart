// Package imports:

import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/plugins/signaling/impl/core/core.dart';


mixin ZegoPluginNotificationService {
  /// enable notification
  Future<ZegoSignalingPluginEnableNotifyResult>
      enableNotifyWhenAppRunningInBackgroundOrQuit(
    bool enabled, {
    bool isIOSSandboxEnvironment = false,
  }) {
    return ZegoSignalingPluginCore.shared.coreData
        .enableNotifyWhenAppRunningInBackgroundOrQuit(
      enabled,
      isIOSSandboxEnvironment: isIOSSandboxEnvironment,
    );
  }
}
