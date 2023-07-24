import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class LeveUpperBody extends StatelessWidget {
  const LeveUpperBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ConfigSize.defaultSize! * 10,
          child: Container(
            width: ConfigSize.defaultSize! * 8,
            height: ConfigSize.defaultSize! * 8,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                image:
                    const DecorationImage(image: AssetImage(AssetsPath.testImage))),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(children: [
                Image.asset(AssetsPath.levelBannerIcon),
                Padding(
                    padding: EdgeInsets.only(left: ConfigSize.defaultSize! * 2),
                    child: Text(
                      "lv.10",
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: ConfigSize.defaultSize! * 1.4),
                    ))
              ]),
            ),
          ),
        ),
        SizedBox(height: ConfigSize.defaultSize!*3,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "level 10",
              style: TextStyle(
                  color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.6),
            ),
            LinearPercentIndicator(
              barRadius: Radius.circular(ConfigSize.defaultSize!),
              width: MediaQuery.of(context).size.width - 130,
              lineHeight: ConfigSize.defaultSize! * 1.2,
              percent: 0.2,
              backgroundColor: Colors.white.withOpacity(0.4),
              progressColor: ColorManager.whiteColor,
            ),
            Text(
              "level 11",
              style: TextStyle(
                  color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.6),
            ),
          ],
        ),
                SizedBox(height: ConfigSize.defaultSize!*3,),

        Text(
          "The number of points you need to upgrade: 800",
          style: TextStyle(
              color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.2),
        ),
                SizedBox(height: ConfigSize.defaultSize!*3,),

      ],
    );
  }
}
