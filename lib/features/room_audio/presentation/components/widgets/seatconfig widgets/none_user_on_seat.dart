// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';

class NoneUserOnSeat extends StatelessWidget {
  Map<dynamic, dynamic> extraInfo;
  NoneUserOnSeat({super.key, required this.extraInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
         top: 110.zH,
          left: extraInfo['index'] == 0
              ? 66.zW
              : 0),
      child: extraInfo['index'] == 0
          ? Image.asset(
        AssetsPath.hostMark,
        width: AppPadding.p20,
        height: AppPadding.p20,
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: colors[1],
            radius: 14.zR,
            child: Text(
              "${extraInfo['index']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.zSP,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            "مقعد",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.zSP,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
