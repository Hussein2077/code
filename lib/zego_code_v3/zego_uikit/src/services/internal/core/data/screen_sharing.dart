// Dart imports:
import 'dart:async';
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/internal.dart';

mixin ZegoUIKitCoreDataScreenSharing {
  StreamController<List<ZegoUIKitCoreUser>> screenSharingListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();

  ZegoScreenCaptureSource? screenCaptureSource;
  ValueNotifier<bool> isScreenSharing = ValueNotifier(false);
  bool isFirstScreenSharing = true;

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
      ZegoUIKitCore.shared.coreData
          .startPublishingStream(streamType: ZegoStreamType.screenSharing);
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

    await ZegoUIKitCore.shared.coreData.stopPublishingStream(
      streamType: ZegoStreamType.screenSharing,
    );

    screenCaptureSource?.stopCapture();

    await ZegoExpressEngine.instance
        .destroyScreenCaptureSource(screenCaptureSource!);
  }
}
