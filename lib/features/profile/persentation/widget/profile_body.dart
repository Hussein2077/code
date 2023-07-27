

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/id_with_copy_icon.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/card1.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/card2.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/card3.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/f_f_f_v_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/gold_sliver_buttons.dart';

class ProfileBody extends StatelessWidget {
  final OwnerDataModel myData ; 
  const ProfileBody({required this.myData , super.key});

  @override
  Widget build(BuildContext context) {
        Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return ScreenColorBackGround(
        color1: isDarkTheme ? Colors.black : ColorManager.lightGray,
        child: Column(
          children: [
        const Spacer(flex: 2,),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.userProfile);
              },
              child: UserInfoRow(
                userData: myData,
                imageSize: ConfigSize.defaultSize! * 7,
                underName:  IdWithCopyIcon(id: myData.uuid.toString()),
                endIcon: Container(
                  padding: EdgeInsets.all(ConfigSize.defaultSize!),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: ColorManager.mainColorList,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                          child: Icon(Icons.arrow_forward_ios ,color:  Colors.white , size: ConfigSize.defaultSize!),
                ),
              ),
            ),
             const Spacer(flex: 1,),

      FFFVRow(userData: myData),
             const Spacer(flex: 1,),

      GoldSilverButton(userData: myData),
             const Spacer(flex: 1,),

     
      Card1(isDarkTheme: isDarkTheme , myData:myData ),
             const Spacer(flex: 1,),

      
      Card2(isDarkTheme: isDarkTheme),
             const Spacer(flex: 1,),

     
      Card3(isDarkTheme: isDarkTheme),
             const Spacer(flex: 1,),


     
          ],
        ),
      );
  }
}