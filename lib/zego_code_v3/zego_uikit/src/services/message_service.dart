
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/message.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';

/// @nodoc
mixin ZegoMessageService {
  /// get in-room messages
  List<ZegoInRoomMessage> getInRoomMessages() {
    return ZegoUIKitCore.shared.coreMessage.messageList;
  }

  /// get in-room messages notifier
  Stream<List<ZegoInRoomMessage>> getInRoomMessageListStream() {
    return ZegoUIKitCore.shared.coreMessage.streamControllerMessageList.stream;
  }

  /// get in-room messages one-by-one notifier
  Stream<ZegoInRoomMessage> getInRoomMessageStream() {
    return ZegoUIKitCore
        .shared.coreMessage.streamControllerRemoteMessage.stream;
  }

  /// get in-room messages one-by-one notifier
  Stream<ZegoInRoomMessage> getInRoomLocalMessageStream() {
    return ZegoUIKitCore.shared.coreMessage.streamControllerLocalMessage.stream;
  }

  /// send in-room message
  /// @return Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
  Future<bool> sendInRoomMessage(String message,bool? changeTheme ,{GamesInRoom? games}) async {
    return ZegoUIKitCore.shared.coreMessage.sendBroadcastMessage(message,changeTheme,games: games??GamesInRoom.normal);
  }

  /// re-send in-room message
  /// @return Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
  Future<bool> resendInRoomMessage(ZegoInRoomMessage message,bool? changeTheme ) async {
    return ZegoUIKitCore.shared.coreMessage.resendInRoomMessage(message,changeTheme);
  }
}
