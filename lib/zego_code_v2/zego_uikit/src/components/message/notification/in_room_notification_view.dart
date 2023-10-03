// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:flutter/material.dart';


// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/in_room_message_view.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/notification/in_room_notification_view_item.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/message_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';

class ZegoInRoomNotificationView extends StatefulWidget {
  final int maxCount;
  final int itemMaxLine;
  final int itemDisappearTime; // ms
  final bool notifyUserLeave;

  final ZegoNotificationUserItemBuilder? userJoinItemBuilder;
  final ZegoNotificationUserItemBuilder? userLeaveItemBuilder;
  final ZegoNotificationMessageItemBuilder? itemBuilder;
   final LayoutMode roomMode;
  final EnterRoomModel room;

  const ZegoInRoomNotificationView({
    Key? key,
    this.maxCount = 3,
    this.itemMaxLine = 3,
    this.itemDisappearTime = 3000,
    this.notifyUserLeave = true,
    this.userJoinItemBuilder,
    this.userLeaveItemBuilder,
    this.itemBuilder,
        required this.room , 
    required this.roomMode , 
  }) : super(key: key);

  @override
  State<ZegoInRoomNotificationView> createState() =>
      _ZegoInRoomNotificationViewState();
}

class _ZegoInRoomNotificationViewState
    extends State<ZegoInRoomNotificationView> {
  // negative growth, because locally sent messages are not accepted, duplicate ids do not occur
  int userMessageID = 0;
  Map<NotificationItemType, List<int>> typeMessages = {}; //  type, message ids

  List<ZegoInRoomMessage> messages = []; //  chat/enter/leave messages,
  var messageListStream = StreamController<List<ZegoInRoomMessage>>.broadcast();
  List<StreamSubscription<dynamic>> streamSubscriptions = [];
  Timer? clearTimeoutTimer;

  @override
  void initState() {
    super.initState();

    typeMessages[NotificationItemType.userJoin] = [];
    typeMessages[NotificationItemType.userLeave] = [];
    typeMessages[NotificationItemType.message] = [];

    clearTimeoutTimer =
        Timer.periodic(const Duration(seconds: 1), clearTimeoutMessage);

    streamSubscriptions
      ..add(ZegoUIKit().getInRoomMessageStream().listen(onInRoomMessage))
      ..add(ZegoUIKit().getUserJoinStream().listen(onUserJoin));
    if (widget.notifyUserLeave) {
      streamSubscriptions
          .add(ZegoUIKit().getUserLeaveStream().listen(onUserLeave));
    }
  }

  @override
  void dispose() {
    super.dispose();

    typeMessages.clear();

    clearTimeoutTimer?.cancel();
    for (final streamSubscription in streamSubscriptions) {
      streamSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZegoInRoomMessageView(
      room:widget.room  ,
      roomMode:widget.roomMode ,
      historyMessages: messages.take(widget.maxCount).toList(),
      scrollable: false,
      stream: messageListStream.stream,
      itemBuilder: (BuildContext context, ZegoInRoomMessage message, _) {
        Widget? messageItem;
        switch (getMessageItemTypeBy(message.messageID)) {
          case NotificationItemType.userJoin:
            messageItem =
                widget.userJoinItemBuilder?.call(context, message.user, {});
            break;
          case NotificationItemType.userLeave:
            messageItem =
                widget.userLeaveItemBuilder?.call(context, message.user, {});
            break;
          case NotificationItemType.message:
            messageItem = widget.itemBuilder?.call(context, message, {});
            break;
        }

        return messageItem ??
            ZegoInRoomNotificationViewItem(
              maxLines: widget.itemMaxLine,
              user: message.user,
              message: message.message,
            );
      },
    );
  }

  void onUserJoin(List<ZegoUIKitUser> users) {
    for (final user in users) {
      if (user.id == ZegoUIKit().getLocalUser().id) {
        continue;
      }

      userMessageID = userMessageID - 1;
      typeMessages[NotificationItemType.userJoin]!.add(userMessageID);
      final message = ZegoInRoomMessage(
        user: user,
        message: 'entered.',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        messageID: userMessageID,
      );
      messages.add(message);
    }
    broadcastStream();
  }

  void onUserLeave(List<ZegoUIKitUser> users) {
    for (final user in users) {
      if (user.id == ZegoUIKit().getLocalUser().id) {
        continue;
      }

      userMessageID = userMessageID - 1;
      typeMessages[NotificationItemType.userLeave]!.add(userMessageID);
      final message = ZegoInRoomMessage(
        user: user,
        message: 'left.',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        messageID: userMessageID,
      );
      messages.add(message);
    }
    broadcastStream();
  }

  void onInRoomMessage(ZegoInRoomMessage message) {
    typeMessages[NotificationItemType.message]!.add(message.messageID);

    messages.add(message);
    broadcastStream();
  }

  void clearTimeoutMessage(Timer _) {
    if (messages.isEmpty) {
      return;
    }

    messages.removeWhere((message) {
      final isTimeoutMessage = DateTime.now()
              .difference(
                  DateTime.fromMillisecondsSinceEpoch(message.timestamp))
              .inMilliseconds >
          widget.itemDisappearTime;
      return isTimeoutMessage;
    });
    refreshTypeMessageIDs();

    broadcastStream();
  }

  void broadcastStream() {
    if (messages.length > widget.maxCount) {
      messages.removeRange(0, messages.length - widget.maxCount);
    }
    refreshTypeMessageIDs();

    messageListStream.add(
        List<ZegoInRoomMessage>.from(messages.take(widget.maxCount).toList()));
  }

  void refreshTypeMessageIDs() {
    typeMessages.forEach((type, messageIDs) {
      messageIDs.removeWhere((messageID) =>
          -1 ==
          messages.indexWhere((message) => message.messageID == messageID));
    });
  }

  NotificationItemType getMessageItemTypeBy(int messageID) {
    var itemType = NotificationItemType.message;
    typeMessages.forEach((type, messageIDs) {
      if (messageIDs.contains(messageID)) {
        itemType = type;
      }
    });

    return itemType;
  }
}
