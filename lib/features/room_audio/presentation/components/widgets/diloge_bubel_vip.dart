import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';


class DilogBubbelVip extends StatelessWidget {
  final int vip;
  final String message;
  final UserDataModel? userData;
  final EnterRoomModel roomData;

  const DilogBubbelVip(
      {Key? key,
        required this.roomData,
        required this.message,
        required this.vip,
        this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (1 == vip || userData == null) {
      return Container();
    }
    else if (2 == vip) {
      return Container();
    } else if (3 == vip) {
      return dilogVip(vip:AssetsPath.bVIP3 , level: 3);
    } else if (4 == vip) {
      return dilogVip(vip:AssetsPath.bVIP4 ,level: 4);
    } else if (5 == vip) {
      return dilogVip(vip:AssetsPath.bVIP5 , level: 5);
    } else if (6 == vip) {
      return dilogVip(vip:AssetsPath.bVIP6 , level: 6);
    } else if (7 == vip) {
      return dilogVip(vip:AssetsPath.bVIP7 ,level: 7);
    } else if (8 == vip) {
      return dilogVip(vip:AssetsPath.bVIP8 , level: 8);
    } else {
      return Container();
    }
  }

  Widget dilogVip ({required String vip , required int level }){
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
            left:level==6?ConfigSize.defaultSize! * 4.7 :(level==5||level==4||level==3)?ConfigSize.defaultSize! *6.3: ConfigSize.defaultSize! * 5.3,
            // left:level==6?ConfigSize.defaultSize! * 4.7 :(level==5||level==4||level==3)?ConfigSize.defaultSize! * 6.3: ConfigSize.defaultSize! * 5.3,
            child: UserImage(
              image: userData!.profile!.image!,

            )),
        Image.asset(
          scale: 0.1,
          // scale: 0.1,
          width: double.infinity,
          vip,
        ),
        Positioned(
          left: ConfigSize.defaultSize! * 12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: TextDirection.rtl,
                children: [
                  //  SizedBox(
                  //   width: ConfigSize.defaultSize!*0.5,
                  // ),

                  AristocracyLevel(
                    level: userData!.vip1!.level! ,
                    scale: 8,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize!*0.2,
                  ),
                  Image.asset(
                    AssetsPath.hostMark,
                    scale: 4,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize!*0.2,
                  ),

                  SizedBox(
                    width: ConfigSize.defaultSize! * 12,
                    child: Text(
                      userData!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppPadding.p10,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: level==3?ConfigSize.defaultSize!*0.5:(level==4||level==5)?ConfigSize.defaultSize!*0.9:0,
                  ),
                ],
              ),

              SizedBox(
                width: ConfigSize.defaultSize! * 23.1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: level==3?ConfigSize.defaultSize!*0.5:(level==4||level==5)?ConfigSize.defaultSize!*0.9:0,
                      ),
                      Text(
                        message,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppPadding.p8,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

