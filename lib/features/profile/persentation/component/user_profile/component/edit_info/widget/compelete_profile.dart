

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CompleteProfile extends StatelessWidget {
  final double percent  ; 
  const CompleteProfile({required this.percent ,  super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
            padding: EdgeInsets.only(left: ConfigSize.defaultSize! , bottom: ConfigSize.defaultSize!),
            width: MediaQuery.of(context).size.width - 50,
            height: ConfigSize.defaultSize! * 10,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AssetsPath.profileCompleteCover),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 " ${StringManager.profileCompleted.tr()} ${percent*100}%",
                  style: TextStyle(
                      color: ColorManager.deeporang,
                      fontSize: ConfigSize.defaultSize! * 2),
                ),
                 LinearPercentIndicator(
                  barRadius: Radius.circular(ConfigSize.defaultSize!),
                width: MediaQuery.of(context).size.width-100,
                lineHeight: ConfigSize.defaultSize!*1.2,
                percent: percent,
                backgroundColor: Colors.deepOrange.withOpacity(0.1),
                progressColor: ColorManager.deeporang,
              ),
              ],
            ),
          );
  }
}