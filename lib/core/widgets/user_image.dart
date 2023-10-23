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

  const UserImage(
      {this.frameId,
      this.frame,
      this.child,
      required this.image,
      this.boxFit,
      this.imageSize,
      super.key});

  @override
  Widget build(BuildContext context) {

     if (image!=""&&image!=null){
    return   Stack(
      alignment: Alignment.center,
      children: [
                 SizedBox(
                 width: imageSize!=null? imageSize!*1.5:  ConfigSize.defaultSize! * 5,
              height:imageSize!=null? imageSize!*1.5:  ConfigSize.defaultSize! * 5,
             ),
        Container(
              width: imageSize??ConfigSize.defaultSize! * 5,
              height:imageSize?? ConfigSize.defaultSize! * 5,
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,

                  image: DecorationImage(
                    fit: boxFit??BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        ConstentApi().getImage(image)) )),
                        child: child,
            ),
            if(frameId!=null&&frameId!=""&&frame!=null&&frame!="")
            SizedBox(
                width: imageSize != null
                    ? imageSize! * 1.5
                    : ConfigSize.defaultSize! * 7,
                height: imageSize != null
                    ? imageSize! * 1.5
                    : ConfigSize.defaultSize! * 7,
                child: ShowSVGA(imageId: "${frameId}Frame", url: frame!))
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
