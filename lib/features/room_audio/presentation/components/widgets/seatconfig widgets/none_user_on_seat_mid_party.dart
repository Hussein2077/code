import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class NoneUserOnSeatMidParty extends StatelessWidget {
  Map<dynamic, dynamic> extraInfo;
  NoneUserOnSeatMidParty({super.key, required this.extraInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: ConfigSize.defaultSize! * 8.4,
          left: ConfigSize.defaultSize! * 2.2),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colors[1],
            radius: ConfigSize.defaultSize! * .9,
            child: Text(
              "${extraInfo['index'] + 1}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            StringManager.empty.tr(),
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
