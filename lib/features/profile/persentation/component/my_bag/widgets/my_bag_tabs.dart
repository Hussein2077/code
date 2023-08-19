import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class MyBagScreenTabs extends StatelessWidget {
  final TabController controller;

  const MyBagScreenTabs({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TabBar(
            controller: controller,
            indicatorColor: ColorManager.orang,
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 6),
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
                fontSize: ConfigSize.defaultSize! * 1.8,
                fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: ConfigSize.defaultSize! * 1.6),
            tabs:  [
              Text(
                StringManager.frames.tr(),
              ),
              Text(
                StringManager.entries.tr(),
              ),
              Text(
                StringManager.bubels.tr(),
              ),
            ]));
  }
}
