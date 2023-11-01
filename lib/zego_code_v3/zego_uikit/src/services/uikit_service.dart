// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/audio_video_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/custom_command_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/device_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/effect_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/media_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/message_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/plugin_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/room_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/user_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/internal.dart';



/// @nodoc
class ZegoUIKit
    with
        ZegoAudioVideoService,
        ZegoRoomService,
        ZegoUserService,
        ZegoMessageService,
        ZegoCustomCommandService,
        ZegoDeviceService,
        ZegoEffectService,
        ZegoPluginService,
        ZegoMediaService,
        ZegoLoggerService {
  factory ZegoUIKit() => instance;

  ZegoUIKit._internal() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  static final ZegoUIKit instance = ZegoUIKit._internal();

  /// version
  Future<String> getZegoUIKitVersion() async {
    return ZegoUIKitCore.shared.getZegoUIKitVersion();
  }

  /// init
  Future<void> init({
    required int appID,
    String appSign = '',
    ZegoScenario scenario = ZegoScenario.Default,
  }) async {
    return ZegoUIKitCore.shared.init(
      appID: appID,
      appSign: appSign,
      scenario: scenario,
    );
  }

  /// uninit
  Future<void> uninit() async {
    return ZegoUIKitCore.shared.uninit();
  }

  /// Set advanced engine configuration, Used to enable advanced functions.
  /// For details, please consult ZEGO technical support.
  Future<void> setAdvanceConfigs(Map<String, String> configs) async {
    await ZegoUIKitCore.shared.setAdvanceConfigs(configs);
  }

  ValueNotifier<DateTime?> getNetworkTime() {
    return ZegoUIKitCore.shared.getNetworkTime();
  }
}
