import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/first_sec_thr_users.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/others_users.dart';

class TopUserTimeBody extends StatelessWidget {
  const TopUserTimeBody({super.key});

  @override
  Widget build(BuildContext context) {
     Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return    SingleChildScrollView(
      child: Column(children: [
        Container(
              width: MediaQuery.of(context).size.width - 50,
              height: ConfigSize.defaultSize! * 27,
              decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: isDarkTheme?  const AssetImage(AssetsPath.topUsersBackGroundBlack):const AssetImage(AssetsPath.topUsersBackGround),
                      fit: BoxFit.fill)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //sec
                    FirstSecThrUsers(
                      badge: AssetsPath.secBadge,
                      height: ConfigSize.defaultSize! * 9,
                      imageSize: ConfigSize.defaultSize! * 7,
                      position: ConfigSize.defaultSize! * 11,
                    ),
        
                    // first
                    FirstSecThrUsers(
                      badge: AssetsPath.firstBadge,
                      height: ConfigSize.defaultSize! * 10,
                      imageSize: ConfigSize.defaultSize! * 9,
                      position: ConfigSize.defaultSize! * 6,
                    ),
                    //third
                    FirstSecThrUsers(
                      badge: AssetsPath.thrBadge,
                      height: ConfigSize.defaultSize! * 9,
                      imageSize: ConfigSize.defaultSize! * 7,
                      position: ConfigSize.defaultSize! * 11,
                    ),
                  ]),
            ),
          const  OthersUsers(),
      ],),
    );
  }
}