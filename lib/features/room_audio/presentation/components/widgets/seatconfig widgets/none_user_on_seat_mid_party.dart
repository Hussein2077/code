import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';

class NoneUserOnSeatMidParty extends StatelessWidget {
  Map<dynamic, dynamic> extraInfo;
  NoneUserOnSeatMidParty({super.key, required this.extraInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 106.zH,
          left: 50.zW),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colors[1],
            radius: 12.zR,
            child: Text(
              "${extraInfo['index'] + 1}",
              style:  TextStyle(
                  color: Colors.white,
                  fontSize: 14.zSP, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          //todo translate that
          Text(
            'مقعد',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.zSP,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
