

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ToastWidget {
  Widget errorToast(String title) {
    return Container(
      height: ConfigSize.defaultSize! * 6.5,
      width: ConfigSize.defaultSize! * 20,

      padding: EdgeInsets.symmetric(
          horizontal: ConfigSize.defaultSize!,
          vertical: ConfigSize.defaultSize! - 3),
      // ignore: sort_child_properties_last
      child: Center(
          child: Text(
        title,
        style: const TextStyle(color: ColorManager.whiteColor),
      )),

      decoration: (
          BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 7, 1, 2),
                Color(0xffFEAE96),
              ]
            ),
          color: Colors.red, 
              borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget sucssesToast(String title) {
    return Container(
      height: ConfigSize.defaultSize! * 5,
      width: ConfigSize.defaultSize! * 20,

      padding: EdgeInsets.symmetric(
          horizontal: ConfigSize.defaultSize!,
          vertical: ConfigSize.defaultSize! - 3),
      // ignore: sort_child_properties_last
      child: Center(
          child: Text(
        title,
        style: const TextStyle(color: ColorManager.whiteColor),
      )),

      decoration: (BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                Color(0xff5AFF15),
                Color(0xff00B712),
              ]
          ),
          color: Colors.green, borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget loadingToast() {
    return Container(
      width: ConfigSize.defaultSize! * 14.5,
      height: ConfigSize.defaultSize! * 3.5,
      padding: EdgeInsets.symmetric(
          horizontal: ConfigSize.defaultSize!,
          vertical: ConfigSize.defaultSize! - 3),
      // ignore: sort_child_properties_last
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringManager.loading,
            style: TextStyle(
                color: ColorManager.whiteColor,
                fontSize: ConfigSize.defaultSize! + 5),
          ),
          AnimateIcon(
              key: UniqueKey(),
              height: ConfigSize.defaultSize! * 2,
              onTap: () {},
              iconType: IconType.continueAnimation,
              // height: AppPadding.p12,
              // width: AppPadding.p12,
              color: ColorManager.whiteColor,
              animateIcon: AnimateIcons.loading7),
        ],
      ),

      decoration: (BoxDecoration(
          gradient: const LinearGradient(
              colors: ColorManager.mainColorList,
              begin: Alignment.centerRight,
              end: Alignment.bottomLeft),
          borderRadius: BorderRadius.circular(20))),
    );
  }
}
