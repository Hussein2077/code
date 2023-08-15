import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';



class HearderTopInRoomScreen extends StatelessWidget {
  final TabController dateController;
  const HearderTopInRoomScreen({required this.dateController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding:const EdgeInsets.all(8),
            child: Text(
              StringManager.diamondsContribution.tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppPadding.p14),
            padding: EdgeInsets.symmetric(
                vertical: AppPadding.p4, horizontal: AppPadding.p4),
            height: ConfigSize.defaultSize! * 4.5,
            decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(AppPadding.p6),
            ),
            child: TabBar(
              controller: dateController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppPadding.p6,
                ),
                color: ColorManager.whiteColor,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: StringManager.hours24.tr()),
                Tab(text: StringManager.total.tr())
              ],
            ),
          )
        ],
      ),
    );
  }
}
