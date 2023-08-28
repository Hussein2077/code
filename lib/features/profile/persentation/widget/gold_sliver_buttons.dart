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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        button(
            image: AssetsPath.goldButton,
            title: StringManager.coins.tr(),
            num: myDataModel.myStore!.coins.toString(),
            gold: true ,
            onTap: () => Navigator.pushNamed(context, Routes.coins , arguments: "gold"),),
      /*  button(
            image: AssetsPath.silverButton,
            title: StringManager.silver.tr(),
            num: myDataModel.myStore!.silverCoin.toString(),
             gold: false
            ,onTap: () => Navigator.pushNamed(context, Routes.coins , arguments: "silver"),
            )*/
      ],
    );
  }
}

Widget button(
    {required String image,
    required String title,
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
        width: ConfigSize.defaultSize! * 18,
        height: ConfigSize.defaultSize! * 7,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: gold ? ColorManager.borwn : Colors.grey,
                  fontSize: ConfigSize.defaultSize! * 1.6),
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
