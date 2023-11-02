import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';


// ignore: must_be_immutable
class AnonymousDialog extends StatefulWidget {


  const AnonymousDialog(
      {
        super.key});

  @override
  State<AnonymousDialog> createState() => _AnonymousDialogState();
}

class _AnonymousDialogState extends State<AnonymousDialog> {
  bool isOnMic = false;

  bool isAdminOrHost = false;

  bool myProfile = false;

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: ConfigSize.screenHeight! * .2,
          decoration: BoxDecoration(
              color: const Color(0xFFFFFCE4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    ConfigSize.defaultSize! * 2.0,
                  ),
                  topRight: Radius.circular(
                    ConfigSize.defaultSize! * 2.0,
                  ))),
        ),
        SizedBox(
          height: ConfigSize.screenHeight! * .2,
          child: Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 7,
              ),
              GradientTextVip(
                text: StringManager.mysteriousPerson.tr(),
                textStyle: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    color: ColorManager.darkBlack,
                    fontWeight: FontWeight.w400),
                isVip:false,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 0.5,
              ),
              Text(
                'ID: ~~~~~~~',
                style: TextStyle(
                  fontSize: ConfigSize.defaultSize! * 1.9,
                  color: Colors.black
                ),
              ),

            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: ConfigSize.screenHeight! * 0.6),
            child: UserImage(
              boxFit: BoxFit.cover,
              imageSize: ConfigSize.defaultSize! * 7.5,
              image: 'hide.png',
            ),
          ),
        ),
      ],
    );
  }

}
