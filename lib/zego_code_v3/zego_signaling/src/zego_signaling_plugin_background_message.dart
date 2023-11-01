





import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/log/logger_service.dart';
import 'package:zego_zpns/zego_zpns.dart';

import '../../zego_uikit/src/plugins/signaling/uikit_signaling_plugin_impl.dart';

/// @nodoc
class ZegoSignalingPluginBackgroundMessageAPIImpl
    implements ZegoSignalingPluginBackgroundMessageAPI {
  /// only for Android
  @override
  Future<ZegoSignalingPluginSetMessageHandlerResult>
      setBackgroundMessageHandler(
    ZegoSignalingPluginZPNsBackgroundMessageHandler handler,
  ) async {
    ZegoSignalingLoggerService.logInfo(
      'register background message handler',
      tag: 'signaling',
      subTag: 'background message',
    );

    if ((!kIsWeb) && (Platform.isAndroid)) {
      ZegoSignalingLoggerService.logInfo(
        'Only Support Android Platform.',
        tag: 'signaling',
        subTag: 'background message',
      );

      return ZegoSignalingPluginSetMessageHandlerResult(
        error: PlatformException(
          code: '-1',
          message: 'Only Support Android Platform.',
        ),
      );
    }

    ZPNs.setBackgroundMessageHandler(handler);

    return const ZegoSignalingPluginSetMessageHandlerResult();
  }

  @override
  Future<ZegoSignalingPluginSetMessageHandlerResult> setThroughMessageHandler(
    ZegoSignalingPluginZPNsThroughMessageHandler handler,
  ) async {
    ZegoSignalingLoggerService.logInfo(
      'register through message handler',
      tag: 'signaling',
      subTag: 'background message',
    );

    if ((!kIsWeb) && (Platform.isAndroid)) {
      ZegoSignalingLoggerService.logInfo(
        'Only Support Android Platform.',
        tag: 'signaling',
        subTag: 'background message',
      );

      return ZegoSignalingPluginSetMessageHandlerResult(
        error: PlatformException(
          code: '-1',
          message: 'Only Support Android Platform.',
        ),
      );
    }

    ZPNsEventHandler.onThroughMessageReceived = handler;

    return const ZegoSignalingPluginSetMessageHandlerResult();
  }
}

/// @nodoc
class ZegoSignalingPluginBackgroundMessageEventImpl
    implements ZegoSignalingPluginBackgroundMessageEvent {}
