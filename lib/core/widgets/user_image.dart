

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class UserImage extends StatelessWidget {
    final double? imageSize ; 

  const UserImage({this.imageSize, super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
          width: imageSize??ConfigSize.defaultSize! * 5,
          height:imageSize?? ConfigSize.defaultSize! * 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(AssetsPath.testImage), fit: BoxFit.fill)),
        );
  }
}