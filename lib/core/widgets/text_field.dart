

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
 final Function(String)? onChanged ;
final void Function()? onTap;
 final double? fontSize;
  const TextFieldWidget({this.obscureText , this.fontSize, this.onChanged, this.type, this.hintColor, this.textColor ,this.readOnly, this.maxLines, required this.hintText, required this.controller, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged:onChanged ,
    
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

                      focusedBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle:  TextStyle(color: hintColor?? Colors.grey)),
                );
  }
}