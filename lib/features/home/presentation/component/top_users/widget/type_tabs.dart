

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class TypeTabs extends StatelessWidget {
  final TabController typeController ; 
  const TypeTabs({required this.typeController ,  super.key});

  @override
  Widget build(BuildContext context) {
           Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
   return Container(
      margin: EdgeInsets.symmetric(horizontal:  ConfigSize.defaultSize!+2),
      decoration: BoxDecoration(
          color:isDarkTheme?Colors.black.withOpacity(0.2): ColorManager.whiteColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5)),
      child: TabBar(
          controller: typeController,
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
               ConfigSize.defaultSize!-3,
            ),
            color: isDarkTheme?Colors.black: ColorManager.whiteColor,
          ),
          tabs:  [
            Text(StringManager.sendGift.tr()),
            Text(StringManager.recevGift.tr()),
          ]),
    );
  }
}