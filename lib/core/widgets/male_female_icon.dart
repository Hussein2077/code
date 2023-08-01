

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class MaleFemaleIcon extends StatelessWidget {
 final String maleOrFeamle ; 
  const MaleFemaleIcon({required this.maleOrFeamle ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize!*3,
      height: ConfigSize.defaultSize!*1.5,
      decoration: BoxDecoration(color: maleOrFeamle=='male'? ColorManager.blue:ColorManager.pink , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
       maleOrFeamle=='male'?  Image.asset(AssetsPath.whiteMaleIcon , scale: 1.5,):  Image.asset(AssetsPath.whiteFemaleIcon , scale: 1.5,),
       Text("22" , style: TextStyle(color: Colors.white , fontSize: ConfigSize.defaultSize!),)
      ],),
    );
  }
}