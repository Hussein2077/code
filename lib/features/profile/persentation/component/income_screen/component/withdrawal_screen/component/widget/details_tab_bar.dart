import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class DetailsScreenTabBar extends StatelessWidget {
 const DetailsScreenTabBar({required this.tabController, super.key});

 final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: tabController,
        isScrollable: false,
        indicatorColor: ColorManager.mainColor,
        indicatorWeight: 1.0,
        indicatorPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*3.0,),
        tabs: [
          Text(StringManager.send.tr(),style: Theme.of(context).textTheme.bodyLarge,),
          Text(StringManager.received.tr(),style: Theme.of(context).textTheme.bodyLarge),
        ]);
  }
}