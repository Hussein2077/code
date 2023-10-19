// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/enter_password_dialog_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/gift_banner_widget.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

class ShowGiftBannerWidget extends StatelessWidget {

  UserDataModel sendDataUser;
  UserDataModel receiverDataUser;
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
              if (isPassword) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(
                              horizontal: ConfigSize.defaultSize! * 0.8),
                          backgroundColor: Colors.transparent,
                          title: const Text(StringManager.enterPassword),
                          content: EnterPasswordRoomDialog(
                            ownerId: ownerId,
                            myData: MyDataModel.getInstance(),
                            isInRoom: true,
                          ));
                    });
              } else {
                Navigator.pop(context);
                MainScreen.iskeepInRoom.value = true;
                Navigator.pushNamed(context, Routes.roomHandler,
                    arguments: RoomHandlerPramiter(
                        ownerRoomId: ownerId, myDataModel: MyDataModel.getInstance()));
              }
            }
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
