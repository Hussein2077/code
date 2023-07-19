

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class UserCountryIcon extends StatelessWidget {
  const UserCountryIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6),
    
      decoration: BoxDecoration(color:Colors.grey.withOpacity(0.5) , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
       Image.asset(AssetsPath.globalIcon , scale: 2.3,),
       Text("دريم" , style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!),)
      ],),
    );
  }
}