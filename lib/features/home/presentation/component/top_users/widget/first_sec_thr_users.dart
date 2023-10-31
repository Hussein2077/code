import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/top_user_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/contaner_vip_or_contribute.dart';

class FirstSecThrUsers extends StatelessWidget {
  final double position;
  final double bottomPosition;

  final double height;

  final String badge;

  final String type;

  final UserTopModel userData;

  const FirstSecThrUsers(
      {required this.userData,
      required this.badge,
      required this.type,
      required this.height,
      required this.position,
      super.key,
        required this.bottomPosition});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Methods.instance.userProfileNvgator(
            context: context, userId: userData.userId.toString());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            badge,
            scale: 2.5,
          ),
          Container(
              margin: EdgeInsets.only(
                top: position,
              ),
              // height: height,
              child: UserImage(
                imageSize:height ,
                image: userData.avater!,
                frameId: userData.frameId,
                frame:userData.frame ,
              )),
          SizedBox(
            width: ConfigSize.defaultSize! * 6,
            child: Text(
              userData.name!,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              type == 'sender'
                  ? Center(
                      child: SizedBox(
                          width: ConfigSize.defaultSize! * 4,
                          height: ConfigSize.defaultSize! * 2,
                          child: LevelContainer(image: userData.senderImage!)),
                    )
                  : Center(
                      child: SizedBox(
                          width: ConfigSize.defaultSize! * 4,
                          height: ConfigSize.defaultSize! * 2,
                          child: LevelContainer(image: userData.receverImage!)),
                    ),

              AristocracyLevel(
                level: userData.vipLevel!,
              ),
            ],
          ),
          Container(
            width: ConfigSize.defaultSize! * 5.6,
            height: ConfigSize.defaultSize! * 1.7,
            margin: EdgeInsets.only(
            bottom: bottomPosition,
          ),
            decoration: BoxDecoration(
                color: ColorManager.bage,
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
            child: Center(
                child: Text(
              userData.exp.toString(),
              style: TextStyle(
                  color: ColorManager.borwn,
                  fontSize: ConfigSize.defaultSize! * 1.2,
                  fontWeight: FontWeight.bold),
            )),
          )
        ],
      ),
    );
  }
}
