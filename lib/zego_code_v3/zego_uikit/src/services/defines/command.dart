// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';

/// The keys below are not allowed to be modified because they are compatible with the web.

/// @nodoc
const removeUserInRoomCommandKey = 'zego_remove_user';



/// @nodoc
const turnMicrophoneOnInRoomCommandKey = 'zego_turn_microphone_on';

/// @nodoc
const turnMicrophoneOffInRoomCommandKey = 'zego_turn_microphone_off';

/// @nodoc
const userIDCommandKey = 'zego_user_id';

/// @nodoc
const muteModeCommandKey = 'zego_mute_mode';

/// @nodoc
class ZegoInRoomCommandReceivedData {
  ZegoUIKitUser fromUser;
  String command;

  ZegoInRoomCommandReceivedData({
    required this.fromUser,
    required this.command,
  });
}
