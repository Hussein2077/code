// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class NoneUserOnSeat extends StatelessWidget {
  Map<dynamic, dynamic> extraInfo;
  NoneUserOnSeat({super.key, required this.extraInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: ConfigSize.defaultSize! * 8.5,
          left: extraInfo['index'] == 0
              ? ConfigSize.defaultSize! * 3.7
              : ConfigSize.defaultSize! * 0.0),
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
            radius: ConfigSize.defaultSize! * .9,
            child: Text(
              "${extraInfo['index']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: AppPadding.p50,
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
                fontSize: AppPadding.p10,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
