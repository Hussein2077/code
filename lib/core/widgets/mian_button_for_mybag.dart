import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class MainButtonForMyBag extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final double? titleSize ;
  final VoidCallback  onTap ; 
  final List<Color>? buttonColor ; 
    final Color? buttonColornotList ; 

  final Color? textColor;
  const MainButtonForMyBag({this.buttonColornotList, this.buttonColor , this.textColor, this.titleSize, required this.onTap ,  required this.title, this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(

        padding: EdgeInsets.all(ConfigSize.defaultSize!*0.3),
        decoration: BoxDecoration(
          color: buttonColornotList,
            gradient: buttonColornotList==null? LinearGradient(colors:buttonColor?? ColorManager.mainColorList):null,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color:textColor?? ColorManager.whiteColor,
                fontSize:titleSize?? ConfigSize.defaultSize! * 1.8 , fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
