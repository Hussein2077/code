import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class ActivityGamesDialog extends StatelessWidget {
  const ActivityGamesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> gamesColumnList = [
      gamesColumn(
          image: AssetsPath.diceIcon, name: StringManager.diceGame.tr(),
      onTap: (){
            Navigator.pop(context);
            ZegoUIKit.instance.sendInRoomMessage(
                "${Random().nextInt(6)}${StringManager.diceGameKey}", false);

      }
      ),
      gamesColumn(image: AssetsPath.guessingIcon, name: StringManager.rps.tr(),onTap: (){
        Navigator.pop(context);
        ZegoUIKit.instance.sendInRoomMessage(
            "${Random().nextInt(3)}${StringManager.rpsGameKey}", false);

      }),
      gamesColumn(
          image: AssetsPath.luckyNumberIcon,
          name: StringManager.luckyNumber.tr()),
      gamesColumn(
          image: AssetsPath.lotteryIcon, name: StringManager.luckyPull.tr()),

      gamesColumn(
          image: AssetsPath.turntableIcon, name: StringManager.turntable.tr()),
    ];
    return Container(
      height: ConfigSize.screenHeight! * .35,
      width: ConfigSize.screenWidth! * .9,
      decoration: BoxDecoration(
          color: ColorManager.darkBlack,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
      child: GridView.builder(
        itemCount: gamesColumnList.length,
        itemBuilder: (context, index) {
          return gamesColumnList[index];
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: ConfigSize.defaultSize! * 2),
      ),
    );
  }

  Widget gamesColumn(
      {required String image, required String name, void Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              image,
              scale: 1.2,
            )),
            SizedBox(
              height: ConfigSize.defaultSize! * .3,
            ),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ConfigSize.defaultSize!,
                  color: ColorManager.whiteColor),
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * .5,
            ),
          ],
        ),
      ),
    );
  }
}
