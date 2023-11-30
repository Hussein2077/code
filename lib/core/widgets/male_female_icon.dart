

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class MaleFemaleIcon extends StatelessWidget {
 final int? maleOrFeamle ;
 final int? age ;
 final double? height;
 final double? width;
  const MaleFemaleIcon({ this.maleOrFeamle ,  this.age ,this.height,this.width , super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
height: height,
      width:width ,
      padding: EdgeInsets.symmetric(
        horizontal: ConfigSize.defaultSize!*0.6,
        vertical: ConfigSize.defaultSize!*0.1
      ),
      decoration: BoxDecoration(color: maleOrFeamle==1? ColorManager.blue:ColorManager.pink , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: ConfigSize.screenWidth!*0.02,
            child: maleOrFeamle == 1 ? Image.asset(
              AssetsPath.whiteMaleIcon, ) : Image.asset(
              AssetsPath.whiteFemaleIcon, ),

          ),

          Text(age.toString(), style: TextStyle(
              color: Colors.white, fontSize: ConfigSize.defaultSize!),)
        ],),
    );
  }
}