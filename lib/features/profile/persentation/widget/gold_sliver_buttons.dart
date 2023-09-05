import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'dart:ui' as ui;


class GoldSilverButton extends StatelessWidget {
  final MyDataModel myDataModel  ;
  const GoldSilverButton({required this.myDataModel ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: ConfigSize.defaultSize! * 1.5
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: button(
              image: AssetsPath.goldButton,
              title: StringManager.coins.tr(),
              num: myDataModel.myStore!.coins.toString(),
              gold: true ,
              onTap: () => Navigator.pushNamed(context, Routes.coins , arguments: "My Videos"),),
          ),
          SizedBox(
            width: ConfigSize.defaultSize! * 1,
          ),
          Expanded(
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Container(
                height: ConfigSize.defaultSize! * 7,

                padding: EdgeInsets.only(
                    right: ConfigSize.defaultSize!-6, top: ConfigSize.defaultSize!*2.5),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(image: AssetImage(AssetsPath.myVideos), fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      StringManager.myVideos.tr(),
                      style: TextStyle(
                          color:  Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ConfigSize.defaultSize! * 1.55),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /*button(
            image: AssetsPath.goldButton,
            title: StringManager.coins.tr(),
            num: myDataModel.myStore!.coins.toString(),
            gold: true ,
            onTap: () => Navigator.pushNamed(context, Routes.coins , arguments: "My Videos"),),*/
        ],
      ),
    );
  }
}

Widget button(
    {required String image,
    required String title,
      BoxFit? boxFit,
    required String num,
    required bool gold ,
    void Function()? onTap}) {
  return InkWell(
    onTap:onTap ,
    child: Directionality(
      textDirection:ui.TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.only(
            right: ConfigSize.defaultSize!, top: ConfigSize.defaultSize!),
        height: ConfigSize.defaultSize! * 7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: AssetImage(image), fit: boxFit?? BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top:gold?0:ConfigSize.defaultSize! * 1),
              child: Text(
                title,
                style: TextStyle(
                    color: gold ? ColorManager.borwn : Colors.black,
                    fontSize: ConfigSize.defaultSize! * 1.6),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: ConfigSize.defaultSize! * 3),
                child: Text(
                  num,
                  style: TextStyle(
                      color: Colors.black, fontSize: ConfigSize.defaultSize! * 1.4),
                ))
          ],
        ),
      ),
    ),
  );
}
