import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/upper/header.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/f_f_f_v_row.dart';

class UpperProfileBody extends StatelessWidget {
  const UpperProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.3,
        decoration: const BoxDecoration(
          image: DecorationImage(
            
            image: AssetImage(AssetsPath.testImage),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.low,
          ),
        ),
        child: BackdropFilter(
          
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:  ConfigSize.defaultSize!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const      Spacer(flex: 6,),
                  const HeaderProfile(),
                          const      Spacer(flex: 2,),
            
                  UserImage(imageSize: ConfigSize.defaultSize! * 8),
                          const      Spacer(flex: 1,),
            
                  Text(
                    "حمودي ابن المحافظ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ConfigSize.defaultSize! * 1.7,
                        fontWeight: FontWeight.bold),
                  ),
                          const      Spacer(flex: 1,),
            
                  Row(
                    children: [
                      SizedBox(
                        width: ConfigSize.defaultSize!,
                      ),
                      Image.asset(
                        AssetsPath.globalIcon,
                        scale: 2,
                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize!,
                      ),
                      itemContiner(title: "24", icon: AssetsPath.whiteFemaleIcon),
                      SizedBox(
                        width: ConfigSize.defaultSize!,
                      ),
                      itemContiner(
                        title: "ID 1507",
                      ),
                    ],
                  ),
                          const      Spacer(flex: 1,),
            
                  Text(
                    "اسمي الحمودي واحب اللعب في  الهههههه",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ConfigSize.defaultSize! * 1.2,
                    ),
                  ),
                          const      Spacer(flex: 5,),
            
                  const FFFVRow(userProfile: true),
                          const      Spacer(flex: 2,),
            
                ],
              ),
            ),
          ),
        ));
  }
}

Widget itemContiner({String? icon, required String title}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      color: Colors.white.withOpacity(0.5),
    ),
    child: Row(children: [
      Text(
        "$title ",
        style: TextStyle(
            color: Colors.white, fontSize: ConfigSize.defaultSize! * 1),
      ),
      if (icon != null)
        Image.asset(
          icon,
          scale: 2,
        )
    ]),
  );
}
