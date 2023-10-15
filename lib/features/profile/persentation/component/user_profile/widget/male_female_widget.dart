import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


// ignore: must_be_immutable
class MaleFemale extends StatelessWidget {
  MaleFemale(
      {required this.bottomColor,
        required this.iconColor,
        required this.gender,
        required this.icon,
        Key? key})
      : super(key: key);

  Color bottomColor;
  Color iconColor;
  String gender;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize! * 15.9,
      height: ConfigSize.defaultSize! * 4.23,
      decoration: BoxDecoration(
          border: Border.all(color: ColorManager.gray),
          color: bottomColor,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5.3)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          color: iconColor,
        ),
        Text(
          gender,
          style: TextStyle(color: iconColor),
        )
      ]),
    );
  }
}
