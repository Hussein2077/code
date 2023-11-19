

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class UserCountryIcon extends StatelessWidget {
  final String country;

  final double? width;

  final double? height;
  final double? fontSize;

  const UserCountryIcon(
      {required this.country,  this.width,  this.height ,this.fontSize,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      width:width,
      height:height,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
      child: Center(
        child: Text(country, style: TextStyle(
            color: Colors.black, fontSize:fontSize?? ConfigSize.defaultSize! * 0.8),),
      ),
    );
  }
}