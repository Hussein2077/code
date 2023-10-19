// Flutter imports:
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';


// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/chat/in_room_chat_view_item.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/in_room_message_view.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/message_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';


class ZegoInRoomChatView extends StatefulWidget {
  final ZegoAvatarBuilder? avatarBuilder;
  final ZegoInRoomMessageItemBuilder? itemBuilder;
  final ScrollController? scrollController;
  final LayoutMode roomMode;
  final EnterRoomModel room;

  const ZegoInRoomChatView({
    Key? key,
    this.avatarBuilder,
    this.itemBuilder,
    this.scrollController,
        required this.room , 
    required this.roomMode , 
  }) : super(key: key);

  @override
  State<ZegoInRoomChatView> createState() => _ZegoInRoomChatViewState();
}

class _ZegoInRoomChatViewState extends State<ZegoInRoomChatView> {
  @override
  Widget build(BuildContext context) {
    return ZegoInRoomMessageView(
      room: widget.room,
      roomMode: widget.roomMode,
      historyMessages: ZegoUIKit().getInRoomMessages(),
      stream: ZegoUIKit().getInRoomMessageListStream(),
      scrollController: widget.scrollController,
      itemBuilder: widget.itemBuilder ??
          (BuildContext context, ZegoInRoomMessage message, _) {
            return Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.0.r, vertical: 20.0.r),
              child: ZegoInRoomChatViewItem(
                avatarBuilder: widget.avatarBuilder,
                message: message,
              ),
            );
          },
    );
  }
}
