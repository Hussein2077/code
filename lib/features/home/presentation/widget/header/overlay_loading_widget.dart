import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/header/cache_data_widget.dart';
class OverlayLoadingCacheWidgetInHome extends StatelessWidget {
  const OverlayLoadingCacheWidgetInHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(
          StringManager.downloadData.tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Container(
          width: ConfigSize.defaultSize! * 18,
          decoration: BoxDecoration(
              color: ColorManager.whiteColor.withOpacity(.5),
              borderRadius:
              BorderRadius.circular(ConfigSize.defaultSize!)),
          child: ValueListenableBuilder(
              valueListenable: CacheDataWidget.notifierDownloadCache,
              builder: (context, show, _) {
                return LinearPercentIndicator(
                  animateFromLastPercent: true,
                  curve: Curves.linearToEaseOut,
                  width: ConfigSize.defaultSize! * 18,
                  animation: true,
                  padding: EdgeInsets.zero,
                  lineHeight: ConfigSize.defaultSize! * .6,
                  animationDuration: 2500,
                  percent: (CacheDataWidget
                      .notifierDownloadCache.value /
                      CacheDataWidget.totalOfData.value) >
                      1
                      ? 1
                      : (CacheDataWidget.notifierDownloadCache.value  /
                      CacheDataWidget.totalOfData.value),
                  backgroundColor: Colors.transparent,
                  barRadius: Radius.circular(ConfigSize.defaultSize! ),
                  linearGradient:const LinearGradient(colors:ColorManager.blueloadingList ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                );
              }),
        ),
      ],
    );
  }
}
