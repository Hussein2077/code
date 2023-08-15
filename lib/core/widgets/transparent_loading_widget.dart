import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/widgets/tik_tok_animition.dart';




class TransparentLoadingWidget extends StatelessWidget {
  final double? width ;
  final double? height ;
  const TransparentLoadingWidget({ this.width,  this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Container(
        width:width ?? double.maxFinite,
        color: Colors.transparent,
        height: height?? double.maxFinite,
        child:const TikTokLoadingAnimation(),
      ));

  }
}