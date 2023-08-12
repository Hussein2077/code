// Dart imports:
import 'dart:async';
import 'dart:io' show Platform;

// Flutter imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/audio_video_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/data/data.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:


extension ZegoUIKitCoreDataScreenSharingExtension on ZegoUIKitCoreData {
  //start screen share
  Future<void> startSharingScreen() async {
    screenCaptureSource =
        await ZegoExpressEngine.instance.createScreenCaptureSource();

    await ZegoExpressEngine.instance
        .setVideoSource(
      ZegoVideoSourceType.ScreenCapture,
      instanceID: screenCaptureSource?.getIndex(),
      channel: ZegoStreamType.screenSharing.channel,
    )
        .then((value) {
      isScreenSharing.value = true;
      startPublishingStream(streamType: ZegoStreamType.screenSharing);
      final config = ZegoScreenCaptureConfig(
        true,
        true,
        microphoneVolume: 100,
        applicationVolume: 100,
      );
      screenCaptureSource?.startCapture(config: config);
    });

    if (isFirstScreenSharing && Platform.isAndroid) {
      isFirstScreenSharing = false;
      await stopSharingScreen();
      startSharingScreen();
    }
  }

  //stop screen share
  Future<void> stopSharingScreen() async {
    isScreenSharing.value = false;

    await stopPublishingStream(streamType: ZegoStreamType.screenSharing);

    screenCaptureSource?.stopCapture();

    await ZegoExpressEngine.instance
        .destroyScreenCaptureSource(screenCaptureSource!);
  }
}

mixin ZegoUIKitCoreDataScreenSharing {
  ZegoScreenCaptureSource? screenCaptureSource;
  ValueNotifier<bool> isScreenSharing = ValueNotifier(false);
  bool isFirstScreenSharing = true;
}
