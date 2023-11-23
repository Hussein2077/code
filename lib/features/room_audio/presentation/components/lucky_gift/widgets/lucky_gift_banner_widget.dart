// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'dart:ui' as ui;


class LuckGiftBannerWidget extends StatelessWidget {

  String giftImage;
  AnimationController controllerBanner;
  Animation<Offset> offsetAnimationBanner;
  int giftNum;
  String reciverName;
  LuckGiftBannerWidget({super.key, required this.giftImage, required this.controllerBanner, required this.offsetAnimationBanner, required this.giftNum, required this.reciverName});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controllerBanner,
        builder: (context, child) {
          return Transform.translate(
              offset: offsetAnimationBanner.value,
              child: Container(
                height: ConfigSize.defaultSize! * 5.5,
                width: ConfigSize.screenWidth !* 0.6,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular( ConfigSize.defaultSize! * 4),
                        bottomRight: Radius.circular(ConfigSize.defaultSize! * 4)),
                    gradient: const   LinearGradient(colors: ColorManager.mainColorList)),
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: Row(
                    children: [
                      UserImage(
                        imageSize: ConfigSize.defaultSize! * 3,
                        image: MyDataModel.getInstance().profile!.image??"",),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyDataModel.getInstance().name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ConfigSize.defaultSize! ),
                          ),
                          Text(
                            "ارسل الي $reciverName ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ConfigSize.defaultSize! * 1),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize! * .5,
                      ),
                      UserImage(
                        image: giftImage,
                        imageSize: ConfigSize.defaultSize! * 2 ,

                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize! * .5,
                      ),

                      Text("${giftNum.toString()}x" ,
                        style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold ,
                            fontSize: ConfigSize.defaultSize!*2),)

                    ],
                  ),
                ),
              ));
        });
  }
}
