

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

class CustomHorizntalDvider extends StatelessWidget {
  final Color? color ; 
  final double width ; 
  const CustomHorizntalDvider({this.color ,  required this.width,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: width ,
    height: 2,
    color:color?? ColorManager.whiteColor.withOpacity(0.2),

    );
  }
}