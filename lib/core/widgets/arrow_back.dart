import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({Key? key, this.color}) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon:   Icon(
        Icons.arrow_back_ios,
        color:color?? ColorManager.darkBlack,
      ),
    );
  }
}
