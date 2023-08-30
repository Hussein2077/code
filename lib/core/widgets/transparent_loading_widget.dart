import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/tik_tok_animition.dart';




class TransparentLoadingWidget extends StatelessWidget {
  final double? width ;
  final double? height ;
  const TransparentLoadingWidget({ this.width,  this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Container(

        width:width ?? ConfigSize.defaultSize!*6.2,
        color: Colors.transparent,
        height: height?? ConfigSize.defaultSize!*2,
        child:const TikTokLoadingAnimation(),
      ));

  }
}