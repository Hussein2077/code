import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui' as ui;

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                Image.asset(AssetsPath.levelBannerIcon),
                Text(
                  "lv. $level",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: ConfigSize.defaultSize! * 1.4),
                )
              ]),
            ),
          ),
        ),
        SizedBox(height: ConfigSize.defaultSize!*3,),
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${StringManager.level.tr()} $level",
                style: TextStyle(
                    color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.2),
              ),
              LinearPercentIndicator(
                barRadius: Radius.circular(ConfigSize.defaultSize!),
                width: MediaQuery.of(context).size.width - 230,
                lineHeight: ConfigSize.defaultSize! * 1.2,
                percent: percent,
                backgroundColor: Colors.white.withOpacity(0.4),
                progressColor: ColorManager.whiteColor,
              ),
              Text(
                "${StringManager.level.tr()} $nextLevel",
                style: TextStyle(
                    color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.2),
              ),
            ],
          ),
        ),
                SizedBox(height: ConfigSize.defaultSize!*3,),

        Text(
          "${StringManager.theNumberOfPoints.tr()}: $levelRemining",
          style: TextStyle(
              color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.2),
        ),
                SizedBox(height: ConfigSize.defaultSize!*3,),

      ],
    );
  }
}
