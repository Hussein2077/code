import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class MentionOrReportContainer extends StatelessWidget {
  final String text;
  final String icon;
  final double? size;

  const MentionOrReportContainer(
      {super.key, required this.text, required this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                fontSize: ConfigSize.defaultSize! * 1.4,
                color: ColorManager.gray,
                fontWeight: FontWeight.w400)),
        SizedBox(
          width: ConfigSize.defaultSize! * 0.7,
        ),
        Image.asset(icon, scale:size?? ConfigSize.defaultSize! * 0.3)
      ],
    );
  }
}
