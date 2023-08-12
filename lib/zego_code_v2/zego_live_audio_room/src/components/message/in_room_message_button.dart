// Flutter imports:
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/message/in_room_message_input_board.dart';



class ZegoInRoomMessageButton extends StatefulWidget {
  final Size? iconSize;
  final Size? buttonSize;
  final EnterRoomModel roomData ;
  final MyDataModel myData ;

  const ZegoInRoomMessageButton({
    Key? key,
    required this.roomData,
    required this.myData ,
    this.iconSize,
    this.buttonSize,
  }) : super(key: key);

  @override
  State<ZegoInRoomMessageButton> createState() =>
      _ZegoInRoomMessageButtonState();
}

class _ZegoInRoomMessageButtonState extends State<ZegoInRoomMessageButton> {
  @override
  Widget build(BuildContext context) {
    return ZegoTextIconButton(
      onPressed: () {
        //
        Navigator.of(context).push(ZegoInRoomMessageInputBoard(roomData: widget.roomData,
            myDataModel:widget.myData));
      },
      icon: ButtonIcon(
        icon:
            PrebuiltLiveAudioRoomImage.asset(PrebuiltLiveAudioRoomIconUrls.im),
      ),
      iconSize: widget.iconSize ?? Size(72.r, 72.r),
      buttonSize: widget.buttonSize ?? Size(96.r, 96.r),
    );
  }
}
