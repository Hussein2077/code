import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class GoldSilverButton extends StatelessWidget {
  const GoldSilverButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        button(
            image: AssetsPath.goldButton,
            title: StringManager.coins,
            num: "1345",
            gold: true , 
            onTap: () => Navigator.pushNamed(context, Routes.coins , arguments: "gold"),),
        button(
            image: AssetsPath.silverButton,
            title: StringManager.silver,
            num: "2945",
            gold: false
            ,onTap: () => Navigator.pushNamed(context, Routes.coins , arguments: "silver"),
            )
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
  );
}
