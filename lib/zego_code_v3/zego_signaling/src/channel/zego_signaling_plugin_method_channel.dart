// Dart imports:
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/log/logger_service.dart';
import 'zego_signaling_plugin_platform_interface.dart';

/// @nodoc
/// An implementation of [ZegoSignalingPluginPlatform] that uses method channels.
class MethodChannelZegoSignalingPlugin extends ZegoSignalingPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zego_uikit_signaling_plugin');

  @override
  Future<void> activeAudioByCallKit() async {
    if (Platform.isIOS) {
      ZegoSignalingLoggerService.logInfo(
        'activeAudioByCallKit',
        tag: 'signaling',
        subTag: '',
      );

      await methodChannel.invokeMethod<String>('activeAudioByCallKit');
    }
  }
}
