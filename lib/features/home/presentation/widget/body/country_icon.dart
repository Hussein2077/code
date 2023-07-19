import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class CountryIcon extends StatelessWidget {
  const CountryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
            margin:  EdgeInsets.only(left: ConfigSize.defaultSize!*2),
            width: ConfigSize.defaultSize!*15,
            padding: EdgeInsets.all(ConfigSize.defaultSize!),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(
                  ConfigSize.defaultSize! * 2,
                )),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Image.asset(AssetsPath.globalIcon , scale: 2,),
                Text(StringManager.countries , style: TextStyle(color: ColorManager.whiteColor , fontSize: ConfigSize.defaultSize!*1.4),),
                const Icon(Icons.keyboard_arrow_down , color: Colors.white,),


              ],),
            ),
          );
  }
}