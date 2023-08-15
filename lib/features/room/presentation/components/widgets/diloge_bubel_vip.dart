import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';


class DilogBubbelVip extends StatelessWidget {
  final int vip;
  final String message;
  final UserDataModel userData;
  final EnterRoomModel roomData;

 const DilogBubbelVip(
      {Key? key,
      required this.roomData,
      required this.message,
      required this.vip,
      required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (1 == vip) {
      return Container();
    }
    else if (2 == vip) {
      return Container();
    } else if (3 == vip) {
      return dilogVip(vip:AssetsPath.bVIP3);
    } else if (4 == vip) {
      return dilogVip(vip:AssetsPath.bVIP4);
    } else if (5 == vip) {
      return dilogVip(vip:AssetsPath.bVIP5);
    } else if (6 == vip) {
      return dilogVip(vip:AssetsPath.bVIP6);
    } else if (7 == vip) {
      return dilogVip(vip:AssetsPath.bVIP7);
    } else if (8 == vip) {
      return dilogVip(vip:AssetsPath.bVIP8);
    } else {
      return Container();
    }
  }

  Widget dilogVip ({required String vip}){
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.centerLeft,
      children: [
        Positioned(
            left: ConfigSize.defaultSize! * 6.3,
            child: UserImage(
              image: userData.profile!.image!,
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
                children: [
                  const SizedBox(
                    width: 4,
                  ),
                  if (userData.id == roomData.ownerId)
                    Image.asset(
                      AssetsPath.hostMark,
                      scale: 3.5,
                    ),
                  AristocracyLevel(
                    level: userData.vip1!.level! ,
                  ),
                  if(userData.level!.senderImage! != '')

                    LevelContainer(
                      image: ConstentApi()
                          .getImage(userData.level!.senderImage!)),

                  if(userData.level!.receiverImage! != '')
                    LevelContainer(
                      image: ConstentApi()
                          .getImage(userData.level!.receiverImage!)),
                  Text(
                    userData.name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppPadding.p12,
                        color: Colors.white),
                  )
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

