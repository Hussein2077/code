

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

import 'profile_row_item.dart';

class Card2 extends StatelessWidget {
    final bool isDarkTheme ; 

  const Card2({required this.isDarkTheme ,  super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MediaQuery.of(context).size.width - 30,
        height: ConfigSize.defaultSize! * 23,
        decoration: BoxDecoration(
              color: isDarkTheme? Colors.grey.withOpacity(0.3):Colors.white,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           const ProfileRowItem(title: StringManager.agency, image:AssetsPath.agencyIcon  ,),
                        ProfileRowItem(title: StringManager.family, image:AssetsPath.familyIcon  , onTap: () => Navigator.pushNamed(context, Routes.familyRanking),),

         const   ProfileRowItem(title: StringManager.rechargeHistory, image:AssetsPath.rechargeHistoryIcon  ,),

         const   ProfileRowItem(title: StringManager.inviteFriend, image:AssetsPath.inviteFriendsIcon  ,),

           
          ],
        ));
  }
}

