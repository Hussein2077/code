


import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/audio_video_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';

/// @nodoc
mixin ZegoDeviceService {
  /// protocol: String is 'operator'
  Stream<String> getTurnOnYourCameraRequestStream() {
    return ZegoUIKitCore
        .shared.coreData.turnOnYourCameraRequestStreamCtrl.stream;
  }

  Stream<ZegoUIKitReceiveTurnOnLocalMicrophoneEvent>
  getTurnOnYourMicrophoneRequestStream() {
    return ZegoUIKitCore
        .shared.coreData.turnOnYourMicrophoneRequestStreamCtrl.stream;
  }

  void enableCustomVideoProcessing(bool enable) {
    ZegoUIKitCore.shared.enableCustomVideoProcessing(enable);
  }
}
