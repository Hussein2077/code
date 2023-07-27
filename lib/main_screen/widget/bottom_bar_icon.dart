

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class BottomIcon extends StatelessWidget {
  final String icon ; 
  const BottomIcon({required this.icon ,  super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ConfigSize.defaultSize!*3,
                                          height:ConfigSize.defaultSize!*3,
                                          child: Image.asset(icon),

    );
  }
}