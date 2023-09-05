

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class LevelContainer extends StatelessWidget {
  final String image ;
  const LevelContainer({required this.image ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ConfigSize.defaultSize!*3,
      height: ConfigSize.defaultSize!*1.5,
decoration: BoxDecoration(image: DecorationImage(image:CachedNetworkImageProvider(

                    ConstentApi().getImage(image)) ,fit: BoxFit.contain )),

    );
  }
}