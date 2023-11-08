// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/chat/chat_view_item.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/message_view.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/screen_util.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
class ZegoInRoomChatView extends StatefulWidget {
  final ZegoAvatarBuilder? avatarBuilder;
  final ZegoInRoomMessageItemBuilder? itemBuilder;
  final ScrollController? scrollController;
  final EnterRoomModel room ;

  const ZegoInRoomChatView({
    Key? key,
    this.avatarBuilder,
    this.itemBuilder,
    this.scrollController,
    required this.room
  }) : super(key: key);

  @override
  State<ZegoInRoomChatView> createState() => _ZegoInRoomChatViewState();
}

/// @nodoc
class _ZegoInRoomChatViewState extends State<ZegoInRoomChatView> {
  @override
  Widget build(BuildContext context) {
    return ZegoInRoomMessageView(
      historyMessages: ZegoUIKit().getInRoomMessages(),
      stream: ZegoUIKit().getInRoomMessageListStream(),
      scrollController: widget.scrollController,
      itemBuilder: widget.itemBuilder ??
          (BuildContext context, ZegoInRoomMessage message, _) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.0.zR, vertical: 20.0.zR),
              child: ZegoInRoomChatViewItem(
                avatarBuilder: widget.avatarBuilder,
                message: message,
              ),
            );
          }, room: widget.room,
    );
  }
}
