

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';

// ignore: must_be_immutable
class AristocracyLevel extends StatelessWidget {
 final int level ; 
   AristocracyLevel({required this.level ,  super.key});

  List<String> levels = [AssetsPath.aristocracy1,
  AssetsPath.aristocracy2,
  AssetsPath.aristocracy3,
  AssetsPath.aristocracy4,
  AssetsPath.aristocracy5,
  AssetsPath.aristocracy6,
  AssetsPath.aristocracy7,
  AssetsPath.aristocracy8];

  @override
  Widget build(BuildContext context) {
    if (level==0){
      return const SizedBox();
    }else {
      return  Image.asset(levels[level-1] ,scale: 6, );
    }



  }
}