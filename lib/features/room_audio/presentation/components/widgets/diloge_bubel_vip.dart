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
      log("elhamody333");
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
            left:level==6?ConfigSize.defaultSize! * 4.7 :(level==5||level==4||level==3)?ConfigSize.defaultSize! * 6.3: ConfigSize.defaultSize! * 5.3,
            child: UserImage(
              image: userData!.profile!.image!,
            )),
        Image.asset(
          scale: 0.1,
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
                textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(
                    width: 4,
                  ),
              
                  AristocracyLevel(
                    level: userData!.vip1!.level! ,
                  ),
                  // if(userData!.level!.senderImage! != '')
                  //
                  //   LevelContainer(
                  //     image: userData!.level!.senderImage!),
                  //         if (userData!.id == roomData.ownerId)
                    Image.asset(
                      AssetsPath.hostMark,
                      scale: 3.5,
                    ),

                  // if(userData!.level!.receiverImage! != '')
                  //   LevelContainer(
                  //     image: userData!.level!.receiverImage!),
                  GradientTextVip(
                    text:userData!.name!,
                    textStyle:TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppPadding.p12,
                        color: Colors.white),

                    isVip: false,
                  ),
                ],
              ),
              
              SizedBox(
                width: ConfigSize.defaultSize! * 23.1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    message,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppPadding.p10,
                        color: Colors.white),
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

