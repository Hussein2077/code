

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller ;  
  final String hintText ; 
  final int? maxLines;
  final Color? textColor; 
    final Color? hintColor; 
    final bool? readOnly;
    final bool? obscureText ;
 final TextInputType? type ;
 final int? maxLength ;
 final Function(String)? onChanged ;
final void Function()? onTap;
final void Function(String)? onSubmitted;
 final double? fontSize;
 final Widget? prefixIcon;
 final Widget? suffixIcon;
  const TextFieldWidget({this.maxLength ,this.suffixIcon, this.prefixIcon, this.obscureText , this.fontSize, this.onChanged, this.type, this.hintColor, this.textColor ,this.readOnly, this.maxLines, required this.hintText, required this.controller, super.key, this.onTap, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(

      maxLength: maxLength,
      onChanged:onChanged ,
                  onSubmitted: onSubmitted,
    
                  style:  TextStyle(color: textColor?? Colors.grey , fontSize: ConfigSize.defaultSize!*1.7),
                  autofocus: false,
                  readOnly: readOnly ?? false,
                  controller: controller,
                  keyboardType: type,
                  maxLines: maxLines??1,
                  obscureText:obscureText??false ,
                  onTap: onTap,
                  decoration:  InputDecoration(
                      border: InputBorder.none,
prefixIcon: prefixIcon,
                      suffixIcon:suffixIcon,
                      focusedBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle:  TextStyle(color: hintColor?? Colors.grey,fontSize: fontSize)),
                );
  }
}