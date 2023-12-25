// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/message/input_board.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_inner_text.dart';

/// @nodoc
class ZegoInRoomMessageInputBoardButton extends StatefulWidget {
  final Size? iconSize;
  final Size? buttonSize;
  final ZegoInnerText innerText;
  final bool rootNavigator;

  final Function(int)? onSheetPopUp;
  final Function(int)? onSheetPop;
  final EnterRoomModel enterRoomModel ;
  const ZegoInRoomMessageInputBoardButton({
    Key? key,
    required this.innerText,
    this.rootNavigator = false,
    this.iconSize,
    this.buttonSize,
    this.onSheetPopUp,
    this.onSheetPop,
   required  this.enterRoomModel
  }) : super(key: key);

  @override
  State<ZegoInRoomMessageInputBoardButton> createState() =>
      _ZegoInRoomMessageInputBoardButtonState();
}

/// @nodoc
class _ZegoInRoomMessageInputBoardButtonState
    extends State<ZegoInRoomMessageInputBoardButton> {
  @override
  Widget build(BuildContext context) {
    return ZegoTextIconButton(
      onPressed: () {
        final key = DateTime.now().millisecondsSinceEpoch;
        widget.onSheetPopUp?.call(key);
        Navigator.of(
          context,
          rootNavigator: widget.rootNavigator,
        ).push(
          ZegoInRoomMessageInputBoard(
            innerText: widget.innerText,
            rootNavigator: widget.rootNavigator,
            roomData: widget.enterRoomModel,
            mention: '',
          ),
        ).then((value) {
          widget.onSheetPop?.call(key);
        });
      },
      icon: ButtonIcon(
        icon:
            PrebuiltLiveAudioRoomImage.asset(PrebuiltLiveAudioRoomIconUrls.im),
      ),
      iconSize: widget.iconSize ?? Size(72.zR, 72.zR),
      buttonSize: widget.buttonSize ?? Size(96.zR, 96.zR),
    );
  }
}
