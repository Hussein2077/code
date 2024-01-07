
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/audio_video.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';

/// @nodoc
mixin ZegoDeviceService {


  Stream<ZegoUIKitReceiveTurnOnLocalMicrophoneEvent>
      getTurnOnYourMicrophoneRequestStream() {
    return ZegoUIKitCore
        .shared.coreData.turnOnYourMicrophoneRequestStreamCtrl.stream;
  }


}
