

import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class CustoumCachedImage extends StatelessWidget{

  final String url ;
  final double width;
  final double height;
  final Widget? errorWidget ;
  final double? radius;
  final Widget? widget;
  final BoxFit? boxFit;

  const  CustoumCachedImage({super.key, required this.url,this.widget,required this.height,required this.width, this.errorWidget, this.radius, this.boxFit});
  @override
  Widget build(BuildContext context) {

    log("Imge VIP  "+url);
    return CachedNetworkImage(
      
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.cover,
      imageUrl: ConstentApi().getImage(url) ,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius??0),
          image: DecorationImage(
              image: imageProvider, fit:boxFit ?? BoxFit.cover),
        ),
        child: widget??const SizedBox(),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
          ),
        ),
      ),
      errorWidget: (context, url, error) => errorWidget ??
          const Icon(Icons.error),
    );
  }
}