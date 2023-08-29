

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class TimeTabs extends StatelessWidget {
  final TabController timeController ; 
  const TimeTabs({required this.timeController ,  super.key});

  @override
  Widget build(BuildContext context) {
              Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
     return Container(
      height: ConfigSize.defaultSize!*5,
      padding: EdgeInsets.symmetric( vertical: ConfigSize.defaultSize!-4 , horizontal: ConfigSize.defaultSize!-3),
      margin: EdgeInsets.symmetric(horizontal:  ConfigSize.defaultSize!+2),
      decoration: BoxDecoration(
          color:isDarkTheme?Colors.black.withOpacity(0.5): ColorManager.whiteColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2)),
      child: TabBar(
          controller: timeController,
          isScrollable: false,
          labelColor: ColorManager.orang,
          unselectedLabelColor: Theme.of(context).colorScheme.primary,
          labelStyle:
               TextStyle(fontWeight: FontWeight.normal, fontSize: ConfigSize.defaultSize!*1.7 ,  ),
          unselectedLabelStyle:
               TextStyle(fontWeight: FontWeight.normal, fontSize: ConfigSize.defaultSize!*1.6),
          labelPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            
            borderRadius: BorderRadius.circular(
               ConfigSize.defaultSize!*2,
            ),
            color:isDarkTheme?Colors.black: ColorManager.whiteColor,
          ),
          tabs:  [
                        Text(StringManager.hours.tr()),

            Text(StringManager.daily.tr()),
            Text(StringManager.weekly.tr()),
                        Text(StringManager.monthly.tr())

            ,
          ]),
    );
  }
}