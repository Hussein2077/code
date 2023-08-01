

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'profile_row_item.dart';

class Card3 extends StatelessWidget {
      final bool isDarkTheme ; 

  const Card3({required this.isDarkTheme ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        height: ConfigSize.defaultSize! * 12,
        decoration: BoxDecoration(
            color:isDarkTheme? Colors.grey.withOpacity(0.3):Colors.white,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileRowItem(title: StringManager.custoumService, image:AssetsPath.customServiceIcon  , onTap: () => Navigator.pushNamed(context, Routes.custoumService),),
                        ProfileRowItem(title: StringManager.settings, image:AssetsPath.settiengsIcon  , onTap: () => Navigator.pushNamed(context, Routes.settings),),

           

           
          ],
        ));
  }
}