import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String title;
  final double? titleSize ;
  final VoidCallback  onTap ; 
  final List<Color>? buttonColor ; 
    final Color? buttonColornotList ; 

  final Color? textColor;
  const MainButton({this.buttonColornotList, this.buttonColor , this.textColor, this.titleSize, required this.onTap ,  required this.title, this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width - 50,
        height: height ?? ConfigSize.defaultSize! * 5.5,
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
