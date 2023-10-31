import 'dart:developer';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'show_svga.dart';

class UserImage extends StatelessWidget {
  final double? imageSize;

  final String image;

  final BoxFit? boxFit;
  final Widget? child;

  final String? frame;

  final int? frameId;

  final bool? isRoom ;

  final double constValue  = 1.7 ;

  const UserImage(
      {this.frameId,
      this.frame,
      this.child,
      required this.image,
      this.boxFit,
      this.imageSize,
      super.key,
         this.isRoom});

  @override
  Widget build(BuildContext context) {
    if (image != "" && image != null) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
             width: imageSize != null
                ? imageSize! * constValue
                : ConfigSize.defaultSize! * 5,
            height: imageSize != null
                ? imageSize! * constValue
                : ConfigSize.defaultSize! * 5,
          ),
          Container(
            width: imageSize ?? ConfigSize.defaultSize! * 5,
            height: imageSize ?? ConfigSize.defaultSize! * 5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: boxFit ?? BoxFit.fill,
                    image: CachedNetworkImageProvider(
                        ConstentApi().getImage(image)))),
            child: child,
          ),
          if ((frameId != null && frameId != "" && frame != null && frame != "")&&(isRoom!=true))
            SizedBox(
                width: imageSize != null
                    ? imageSize! * constValue
                    : ConfigSize.defaultSize! * 7,
                height: imageSize != null
                    ? imageSize! * constValue
                    : ConfigSize.defaultSize! * 7,
                child: ShowSVGA(imageId: "${frameId}Frame", url: frame!)),

           if (isRoom??false)
            SizedBox(
                width: imageSize != null
                    ? imageSize! * 1.85
                    : ConfigSize.defaultSize! * 7,
                height: imageSize != null
                    ? imageSize! * 1.85
                    : ConfigSize.defaultSize! * 7,
                child: Image.asset(AssetsPath.isRoomGIF,)),


        ],
      );
    } else {
      return Container(
        width: imageSize ?? ConfigSize.defaultSize! * 5,
        height: imageSize ?? ConfigSize.defaultSize! * 5,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: boxFit ?? BoxFit.fill,
                image: const AssetImage(
                  AssetsPath.defaultImage,
                ))),
        child: child,
      );
    }
  }
}
