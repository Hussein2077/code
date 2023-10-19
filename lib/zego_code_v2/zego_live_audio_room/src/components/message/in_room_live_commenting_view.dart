// Flutter imports:
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import '../../../../zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/message/in_room_live_commenting_view_item.dart';




class ZegoInRoomLiveCommentingView extends StatefulWidget {
  final ZegoInRoomMessageItemBuilder? itemBuilder;
    final LayoutMode roomMode;
  final EnterRoomModel room;
  const ZegoInRoomLiveCommentingView({
    Key? key,
    this.itemBuilder,
        required this.room , 
    required this.roomMode , 
  }) : super(key: key);

  @override
  State<ZegoInRoomLiveCommentingView> createState() =>
      _ZegoInRoomLiveCommentingViewState();
}

class _ZegoInRoomLiveCommentingViewState
    extends State<ZegoInRoomLiveCommentingView> {
  @override
  Widget build(BuildContext context) {
    return ZegoInRoomMessageView(
      room: widget.room,
      roomMode: widget.roomMode,
      historyMessages: ZegoUIKit().getInRoomMessages(),
      stream: ZegoUIKit().getInRoomMessageListStream(),
      itemBuilder: widget.itemBuilder ??
          (BuildContext context, ZegoInRoomMessage message, _) {
            return ZegoInRoomLiveCommentingViewItem(
              user: message.user,
              message: message.message,
            );
          },
    );
  }
}
