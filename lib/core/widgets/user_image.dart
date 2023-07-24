

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';


class UserImage extends StatelessWidget {
    final double? imageSize ; 
    final String image ; 

  const UserImage({required this.image ,  this.imageSize, super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
          width: imageSize??ConfigSize.defaultSize! * 5,
          height:imageSize?? ConfigSize.defaultSize! * 5,
          decoration:  BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:CachedNetworkImageProvider(
                    
                    ConstentApi().getImage(image)) )),
        );
  }
}