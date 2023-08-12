// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/message_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';

typedef ZegoInRoomMessageItemBuilder = Widget Function(
  BuildContext context,
  ZegoInRoomMessage message,
  Map<String, dynamic> extraInfo,
);

typedef ZegoNotificationUserItemBuilder = Widget Function(
  BuildContext context,
  ZegoUIKitUser user,
  Map<String, dynamic> extraInfo,
);

typedef ZegoNotificationMessageItemBuilder = Widget Function(
  BuildContext context,
  ZegoInRoomMessage message,
  Map<String, dynamic> extraInfo,
);

enum NotificationItemType {
  userJoin,
  userLeave,
  message,
}
