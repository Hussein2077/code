// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/message.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

/// @nodoc
class ZegoUIKitCoreMessage {
  int localMessageId = 0;
  List<ZegoInRoomMessage> messageList = []; // uid:user

  StreamController<List<ZegoInRoomMessage>> streamControllerMessageList =
      StreamController<List<ZegoInRoomMessage>>.broadcast();
  StreamController<ZegoInRoomMessage> streamControllerRemoteMessage =
      StreamController<ZegoInRoomMessage>.broadcast();
  StreamController<ZegoInRoomMessage> streamControllerLocalMessage =
      StreamController<ZegoInRoomMessage>.broadcast();

  void onIMRecvBroadcastMessage(
      String roomID, List<ZegoBroadcastMessageInfo> _messageList) {
    for (final _message in _messageList) {
      final message = ZegoInRoomMessage.fromBroadcastMessage(_message);
      streamControllerRemoteMessage.add(message);
      messageList.add(message);
    }

    if (messageList.length > 500) {
      messageList.removeRange(0, messageList.length - 500);
    }

    streamControllerMessageList.add(List<ZegoInRoomMessage>.from(messageList));
  }

  void clear() {
    messageList.clear();
    streamControllerMessageList.add(List<ZegoInRoomMessage>.from(messageList));
  }

  Future<bool> sendBroadcastMessage(String message,bool? changeTheme,{required GamesInRoom games}) async {
    localMessageId = localMessageId - 1;

    final messageItem = ZegoInRoomMessage(
      changeTheme:changeTheme,
      messageID: localMessageId,
      user: ZegoUIKitCore.shared.coreData.localUser.toZegoUikitUser(),
      message: message,
      games:games,
      timestamp:
          ZegoUIKitCore.shared.coreData.networkDateTime_.millisecondsSinceEpoch,
    );
    messageItem.state.value = ZegoInRoomMessageState.idle;

    messageList.add(messageItem);
    streamControllerMessageList.add(List<ZegoInRoomMessage>.from(messageList));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (ZegoInRoomMessageState.idle == messageItem.state.value) {
        /// if the status is still Idle after 300 ms,  it mean the message is not sent yet.
        messageItem.state.value = ZegoInRoomMessageState.sending;
        streamControllerMessageList
            .add(List<ZegoInRoomMessage>.from(messageList));
      }
    });

    return ZegoExpressEngine.instance
        .sendBroadcastMessage(ZegoUIKitCore.shared.coreData.room.id, message)
        .then((ZegoIMSendBroadcastMessageResult result) {
      messageItem.state.value = (result.errorCode == 0)
          ? ZegoInRoomMessageState.success
          : ZegoInRoomMessageState.failed;

      if (0 == result.errorCode) {
        messageItem.messageID = result.messageID;
      }
      streamControllerLocalMessage.add(messageItem);

      streamControllerMessageList
          .add(List<ZegoInRoomMessage>.from(messageList));

      return 0 == result.errorCode;
    });
  }

  Future<bool> resendInRoomMessage(ZegoInRoomMessage message,bool? changeTheme) async {
    messageList.removeWhere((element) => element.messageID == message.messageID);
    return sendBroadcastMessage(message.message,changeTheme, games: GamesInRoom.normal);
  }
}
