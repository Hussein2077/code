import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';

class LeveUpperBody extends StatelessWidget {
  final String userImage ;
  final String level ; 
  final String nextLevel ; 
  final double percent ; 
  final String levelRemining ; 
  
  const LeveUpperBody({required this.levelRemining ,  required this.level , required this.nextLevel , required this.percent , required this.userImage , super.key});

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
                image: DecorationImage(image:   CachedNetworkImageProvider(
                    
                    ConstentApi().getImage(userImage)))
                ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(children: [
                Image.asset(AssetsPath.levelBannerIcon),
                Padding(
                    padding: EdgeInsets.only(left: ConfigSize.defaultSize! * 2),
                    child: Text(
                      "lv. $level",
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
              "${StringManager.level} $level",
              style: TextStyle(
                  color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.6),
            ),
            LinearPercentIndicator(
              barRadius: Radius.circular(ConfigSize.defaultSize!),
              width: MediaQuery.of(context).size.width - 130,
              lineHeight: ConfigSize.defaultSize! * 1.2,
              percent: percent,
              backgroundColor: Colors.white.withOpacity(0.4),
              progressColor: ColorManager.whiteColor,
            ),
            Text(
              "${StringManager.level} $nextLevel",
              style: TextStyle(
                  color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.6),
            ),
          ],
        ),
                SizedBox(height: ConfigSize.defaultSize!*3,),

        Text(
          "${StringManager.theNumberOfPoints}: $levelRemining",
          style: TextStyle(
              color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.2),
        ),
                SizedBox(height: ConfigSize.defaultSize!*3,),

      ],
    );
  }
}
