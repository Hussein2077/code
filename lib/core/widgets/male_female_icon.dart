

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class MaleFemaleIcon extends StatelessWidget {
 final int? maleOrFeamle ;
 final int? age ;
  const MaleFemaleIcon({ this.maleOrFeamle ,  this.age ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize!*3,
      height: ConfigSize.defaultSize!*1.5,
      decoration: BoxDecoration(color: maleOrFeamle==1? ColorManager.blue:ColorManager.pink , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
       maleOrFeamle==1?  Image.asset(AssetsPath.whiteMaleIcon , scale: 1.5,):  Image.asset(AssetsPath.whiteFemaleIcon , scale: 1.5,),
       Text(age.toString(), style: TextStyle(color: Colors.white , fontSize: ConfigSize.defaultSize!),)
      ],),
    );
  }
}