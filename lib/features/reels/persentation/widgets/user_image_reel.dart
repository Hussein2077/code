



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';


class UserImageReel extends StatelessWidget {
  final double? imageSize ;
  final String image ;
  final BoxFit? boxFit;
  final Widget? child ;
  final bool isFollowed ;


  const UserImageReel({this.child ,
  required this.image ,
  required this.isFollowed,
  this.boxFit ,this.imageSize, super.key});

@override
Widget build(BuildContext context) {
  return  Stack(
    children: [
      SizedBox(
        width: ConfigSize.defaultSize! * 5,
        height:ConfigSize.defaultSize! * 6 ,
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
    Positioned(
        bottom: 0,
        right: 10,
        child: Container(

      decoration:const BoxDecoration(
        shape:  BoxShape.circle,
        color: Colors.red,
      ),
          padding:const  EdgeInsets.all(4) ,
      child:  Icon(CupertinoIcons.add,size: ConfigSize.defaultSize!+4,),
    ))
    ],
  ) ;
}
}