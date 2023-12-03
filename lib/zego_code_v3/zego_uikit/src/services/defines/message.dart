// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';

///
enum ZegoInRoomMessageState {
  idle,
  sending,
  success,
  failed,
}

/// in-room message
class ZegoInRoomMessage {
  /// If the local message sending fails, then the message ID at this time is unreliable, and is a negative sequential value.
  int messageID;

  /// message sender.
  ZegoUIKitUser user;

  /// message content.
  String message;

  GamesInRoom games ;
  bool? changeTheme ;
  /// The timestamp at which the message was sent.
  /// You can format the timestamp, which is in milliseconds since epoch, using DateTime.fromMillisecondsSinceEpoch(timestamp).
  int timestamp;
  var state =
      ValueNotifier<ZegoInRoomMessageState>(ZegoInRoomMessageState.success);

  ZegoInRoomMessage({
    required this.user,
    required this.message,
    required this.timestamp,
    required this.messageID,
    this.changeTheme,
    this.games=GamesInRoom.normal,
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
    return '{id:$messageID, user:$user message:$message, timestamp:$timestamp}';
  }
}
