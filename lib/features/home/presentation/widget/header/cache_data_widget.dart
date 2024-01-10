import 'dart:developer';

import 'package:animated_icon/animated_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/header/overlay_loading_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/item_widget_for_cache.dart';

class CacheDataWidget extends StatefulWidget {
  const CacheDataWidget({Key? key}) : super(key: key);

  static Map<String, ItemWidget> cacheData = {};
  static ValueNotifier<int> notifierCacheData = ValueNotifier<int>(0);
  static ValueNotifier<int> showDownloadLoading = ValueNotifier<int>(-1);
  static ValueNotifier<double> notifierDownloadCache =
      ValueNotifier<double>(0.0);

  static ValueNotifier<double> totalOfData = ValueNotifier<double>(0);

  @override
  State<CacheDataWidget> createState() => _CacheDataWidgetState();
}

class _CacheDataWidgetState extends State<CacheDataWidget> {
  late OverlayState overlayState;
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    overlayState = Overlay.of(context);
    CacheDataWidget.showDownloadLoading.addListener(() {
      if (CacheDataWidget.showDownloadLoading.value == 1) {
        overlayState.insert(overlayEntry);
      } else if (CacheDataWidget.showDownloadLoading.value == 0) {
        overlayEntry.remove();
        CacheDataWidget.totalOfData.value = 0.0;
        CacheDataWidget.notifierDownloadCache.value = 0.0;
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(ConfigSize.defaultSize!),
          child: const Align(
              alignment: Alignment.topCenter,
              child: OverlayLoadingCacheWidgetInHome()),
        );
      },
    );
    return ValueListenableBuilder<int>(
        valueListenable: CacheDataWidget.notifierCacheData,
        builder: (context, value, _) {
          if (CacheDataWidget.cacheData.isNotEmpty) {
            return DropdownButtonHideUnderline(
              child: DropdownButton2<ItemWidget>(
                items: CacheDataWidget.cacheData.values
                    .toList()
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: item,
                        ))
                    .toList(),
                onChanged: (value) {
                  onChangedCacheInDropDownHome(value);
                },
                isExpanded: true,
                hint: Text(
                  StringManager.cache.tr(),
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.2,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.whiteColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                ),
                buttonWidth: ConfigSize.defaultSize! * 12,
                dropdownWidth: ConfigSize.defaultSize! * 15,
                icon: AnimateIcon(
                  key: UniqueKey(),
                  onTap: () {},
                  iconType: IconType.continueAnimation,
                  height: ConfigSize.defaultSize! * 4,
                  width: ConfigSize.defaultSize! * 4,
                  color: ColorManager.whiteColor,
                  animateIcon: AnimateIcons.cloud,
                ),
                offset: const Offset(25, 5),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  void onChangedCacheInDropDownHome(ItemWidget? value) {
    if (value?.text == StringManager.cacheGift.tr()) {
      removeFromListLocalToAvoidDownloadDataMoreThanOne(
          StringManager.lastTimeCacheGift);
      Methods.instance.chachGiftInRoom();
    } else if (value?.text == StringManager.cacheExtra.tr()) {
      removeFromListLocalToAvoidDownloadDataMoreThanOne(
          StringManager.lastTimeCacheExtra);

      Methods.instance.getAndLoadExtraData();
    } else if (value?.text == StringManager.cacheFrame.tr()) {
      removeFromListLocalToAvoidDownloadDataMoreThanOne(
          StringManager.lastTimeCacheFrame);

      Methods.instance.getAndLoadFrames();
    } else if (value?.text == StringManager.cacheIntro.tr()) {
      removeFromListLocalToAvoidDownloadDataMoreThanOne(
          StringManager.lastTimeCacheEntro);

      Methods.instance.getAndLoadEntro();
    } else if (value?.text == StringManager.cacheEmoji.tr()) {
      removeFromListLocalToAvoidDownloadDataMoreThanOne(
          StringManager.lastTimeCacheEmojie);
      Methods.instance.getAndLoadEmojie();
    }
    // sucssesToast(context: context, title: StringManager.dataLoaded.tr());
  }

  void removeFromListLocalToAvoidDownloadDataMoreThanOne(String text) {
    CacheDataWidget.cacheData.remove(text);
    CacheDataWidget.notifierCacheData.value =
        CacheDataWidget.notifierCacheData.value + 1;
  }
}
