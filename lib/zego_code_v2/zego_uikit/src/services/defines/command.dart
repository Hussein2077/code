// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';


const removeUserInRoomCommandKey = 'zego_remove_user';
const turnCameraOnInRoomCommandKey = 'zego_turn_camera_on';
const turnCameraOffInRoomCommandKey = 'zego_turn_camera_off';
const turnMicrophoneOnInRoomCommandKey = 'zego_turn_microphone_on';
const turnMicrophoneOffInRoomCommandKey = 'zego_turn_microphone_off';
/// @nodoc
const userIDCommandKey = 'zg_user_id';

/// @nodoc
const muteModeCommandKey = 'zg_mute_mode';

class ZegoInRoomCommandReceivedData {
  ZegoUIKitUser fromUser;
  String command;

  ZegoInRoomCommandReceivedData({
    required this.fromUser,
    required this.command,
  });
}
