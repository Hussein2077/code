




import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class CachedNetworkImgeCircular extends StatelessWidget {
  final String image ;
  final double width ;
  final double hight ;
  final Widget? placeHolder ;
  const CachedNetworkImgeCircular({required this.hight ,  this.placeHolder, required this.width , required this.image ,  super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width:width,
        height: hight,
        imageUrl: ConstentApi().getImage(image),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) =>Shimmer.fromColors(
          baseColor: Colors.grey[850]!,
          highlightColor: Colors.grey[800]!,
          child: Container(
            width: ConfigSize.defaultSize!*5.7,
            height:  ConfigSize.defaultSize!*5.7,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape:BoxShape.circle ,
            ),
          ),
        ),
        errorWidget: (context, url, error) => placeHolder??   Container(
          decoration:const  BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(AssetsPath.iconApp), fit: BoxFit.cover),
          ),
        )

    ) ;
  }
}