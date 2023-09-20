// Flutter imports:
import 'package:flutter/material.dart';


// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';

enum ZegoInRoomMessageState {
  idle,
  sending,
  success,
  failed,
}

class ZegoInRoomMessage {
  int messageID;
  ZegoUIKitUser user;
  String message;
  int timestamp;
    bool? changeTheme;

  var state =
      ValueNotifier<ZegoInRoomMessageState>(ZegoInRoomMessageState.success);

  ZegoInRoomMessage({
    required this.user,
    required this.message,
    required this.timestamp,
    required this.messageID,
     this.changeTheme , 
  });

  ZegoInRoomMessage.fromBroadcastMessage(ZegoBroadcastMessageInfo message)
      : this(
          user: ZegoUIKitUser.fromZego(message.fromUser),
          message: message.message,
          timestamp: message.sendTime,
          messageID: message.messageID,
        );

  @override
  String toString() {
    return 'id:$messageID, user:$user message:$message, timestamp:$timestamp';
  }
}
