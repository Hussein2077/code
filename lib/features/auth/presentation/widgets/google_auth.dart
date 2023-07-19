

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(width: ConfigSize.defaultSize!*5,
        
        height: ConfigSize.defaultSize!*5,
         child: Center(child: Image.asset(AssetsPath.googleIcon),));
  }
}