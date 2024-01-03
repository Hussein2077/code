import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
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
  final MyDataModel myData;

  const ProfileBody({required this.myData, super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Container(

      margin: EdgeInsets.only(bottom: ConfigSize.defaultSize!*3),
      child: ScreenColorBackGround(
        withoutHighit: true,
        color1: isDarkTheme ? Colors.black : ColorManager.lightGray,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
           SizedBox(height: ConfigSize.defaultSize!,),
              UserInfoRow(
                imageSize: ConfigSize.defaultSize! * 6,
                underName: IdWithCopyIcon(userData: myData ),
                endIcon: const SizedBox(),
                userData: myData.convertToUserObject(),
              ),
              SizedBox(height: ConfigSize.defaultSize!*1.5,),

              FFFVRow(
                myDataModel: myData,
              ),
              SizedBox(height: ConfigSize.defaultSize!*1.5,),

              GoldSilverButton(
                myDataModel: myData,
              ),
              SizedBox(height: ConfigSize.defaultSize!*3.5,),

              Card1(
                isDarkTheme: isDarkTheme,
                myData: myData,
              ),
              SizedBox(height: ConfigSize.defaultSize!*3.5,),
              Card2(
                isDarkTheme: isDarkTheme,
                myData: myData,
              ),
              SizedBox(height: ConfigSize.defaultSize!*3.5,),

              Card3(
                isDarkTheme: isDarkTheme,
                myData: myData,
              ),


            ],
          ),
        ),
      ),
    );
  }
}