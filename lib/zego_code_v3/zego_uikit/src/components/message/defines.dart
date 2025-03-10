// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
/// Chat message list builder for customizing the display of chat messages.
typedef ZegoInRoomMessageItemBuilder = Widget Function(
  BuildContext context,
  ZegoInRoomMessage message,
  Map<String, dynamic> extraInfo,
);

/// @nodoc
typedef ZegoNotificationUserItemBuilder = Widget Function(
  BuildContext context,
  ZegoUIKitUser user,
  Map<String, dynamic> extraInfo,
);

/// @nodoc
typedef ZegoNotificationMessageItemBuilder = Widget Function(
  BuildContext context,
  ZegoInRoomMessage message,
  Map<String, dynamic> extraInfo,
);

/// @nodoc
enum NotificationItemType {
  userJoin,
  userLeave,
  message,
}
