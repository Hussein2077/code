import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ImageWithText extends StatelessWidget {
 final String text;
 final String image;
  const ImageWithText({super.key,required this.image,required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image,scale: ConfigSize.defaultSize! * 0.29,),
        Text(text,style:  TextStyle(
          color: ColorManager.darkBlack,
          fontSize: ConfigSize.defaultSize! * 1
        ),)
      ],
    );
  }
}



