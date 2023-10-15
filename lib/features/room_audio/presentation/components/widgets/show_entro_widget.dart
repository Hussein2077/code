// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import '../../Room_Screen.dart';

class ShowEntroWidget extends StatelessWidget {

  Map<String,String> userIntroData;
  var offsetAnimationEntro;
  ShowEntroWidget({super.key, required this.userIntroData, this.offsetAnimationEntro});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 8)).then((value) {
      RoomScreen.showEntro.value = false;
    });

    return Positioned(
      bottom: ConfigSize.defaultSize! * 17,
      child: SizedBox(
          height: AppPadding.p40,
          child: SlideTransition(
            position: offsetAnimationEntro,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: UserImage(
                    image:userIntroData['user_image_intro']??'' ,
                    imageSize: AppPadding.p40,
                  ),
                ),
                Text(
                  userIntroData['user_name_intro']??'',
                  style: const TextStyle(
                      color: ColorManager.gold,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const Text(
                  "  has Join",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          )),
    );
  }
}
