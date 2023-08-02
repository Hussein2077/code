import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class FamilyRankTabs extends StatelessWidget {
  final TabController rankingController;
  const FamilyRankTabs({required this.rankingController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize! * 5,
      padding: EdgeInsets.symmetric(
          vertical: ConfigSize.defaultSize! - 4,
          horizontal: ConfigSize.defaultSize! - 3),
      margin: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! + 2),
      decoration: BoxDecoration(
          color: ColorManager.whiteColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
      child: TabBar(
          controller: rankingController,
          isScrollable: false,
          labelColor: ColorManager.whiteColor,
          unselectedLabelColor: ColorManager.whiteColor,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: ConfigSize.defaultSize! * 1.8,
          ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: ConfigSize.defaultSize! * 1.6),
          labelPadding: EdgeInsets.zero,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ConfigSize.defaultSize! * 2,
            ),
            color: ColorManager.whiteColor.withOpacity(0.5),
          ),
          tabs:  [
            Text(StringManager.daily.tr()),
            Text(StringManager.weekly.tr()),
            Text(StringManager.monthly.tr()),
          ]),
    );
  }
}
