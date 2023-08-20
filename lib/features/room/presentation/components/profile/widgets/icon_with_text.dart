import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class IconWithText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  const IconWithText({super.key,required this.icon,required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap,
      child: Row(
        children: [
          Text(text,style: const TextStyle(

            color: ColorManager.gray,
          ),),
          SizedBox(
            width: ConfigSize.defaultSize! * 0.5,
          ),
          Icon(icon,color: ColorManager.gray,size: ConfigSize.defaultSize! * 1.8),


        ],
      ),
    );
  }
}
