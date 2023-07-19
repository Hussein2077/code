import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';

import 'widgets/lower_body.dart';
import 'widgets/upper_body.dart';

class UserLevelBody extends StatelessWidget {
  const UserLevelBody({super.key});

  @override
  Widget build(BuildContext context) {
    return    ScreenColorBackGround(
            color: ColorManager.mainColorList,
            child: Column(
              children: [

                SizedBox(
                  height: ConfigSize.defaultSize! * 3.5,
                ),
                
                const LeveUpperBody(),
                const LowerBody(),
              ],
            ));
  }
}