// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/gift_banner_widget.dart';

class ShowGiftBannerWidget extends StatelessWidget {

  RoomVistorModel sendDataUser;
  RoomVistorModel receiverDataUser;
  String giftImage;
  String ownerId;
  bool isPlural;
  AnimationController controllerBanner;
  Animation<Offset> offsetAnimationBanner;
  bool isPassword;
  String roomOwnerId;
  bool showGift;
  var roomIntro;
  ShowGiftBannerWidget({super.key, required this.sendDataUser, required this.receiverDataUser, required this.giftImage, required this.ownerId, required this.isPlural, required this.controllerBanner, required this.offsetAnimationBanner, required this.isPassword, required this.roomOwnerId, required this.showGift, required this.roomIntro});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (roomOwnerId != ownerId) {
            if (!showGift) {
              Methods.instance.checkIfRoomHasPassword(
                  context: context,
                  isInRoom: true,
                  isBanner: true,
                  hasPassword: isPassword,
                  ownerId: ownerId.toString(),
                  myData: MyDataModel.getInstance());
            }
          }else{

          }
        },
        child: GiftBannerWidget(
            giftImage: giftImage,
            isPlural: isPlural,
            receiverDataUser: receiverDataUser,
            roomIntro: roomIntro,
            sendDataUser: sendDataUser,
            controllerBanner: controllerBanner,
            offsetAnimationBanner: offsetAnimationBanner));
  }
}
