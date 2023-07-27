import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ContinerWithIcons extends StatelessWidget {
  final IconData? icon1 ; 
 final IconData? icon2 ; 
 final Widget widget ;
 final Color? color ; 
  const ContinerWithIcons({this.color,   this.icon1 ,this.icon2 , required this.widget ,   super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
      width: MediaQuery.of(context).size.width - 50,
      height: ConfigSize.defaultSize! * 6,
      decoration: BoxDecoration(
          color:color?? ColorManager.lightGray,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 3)),
          child: Row(
            
            children: [
            Icon(icon1 , color: Colors.grey,),
            SizedBox(width: ConfigSize.defaultSize,),
            widget , 
            const Spacer(),
            Icon(icon2 , color: Colors.grey,),


          ],),
    );
  }
}
