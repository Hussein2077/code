// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/enter_password_dialog_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/show_lucky_banner_body_widget.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

class ShowLuckyBannerWidget extends StatelessWidget {

  UserDataModel sendDataUser;
  var superBox;
  var showBannerLuckyBox;
  String ownerId;
  ShowLuckyBannerWidget({super.key, required this.sendDataUser, required this.superBox, required this.showBannerLuckyBox, required this.ownerId});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 8)).then((value) {
      if (showBannerLuckyBox.value) {
        showBannerLuckyBox.value = false;
      }
    });
    return AnimatedOpacity(
      opacity: showBannerLuckyBox.value ? 1.0 : 0.0,
      duration: const Duration(seconds: 5),
      child: InkWell(
        onTap: () async {
          if (ownerId != superBox['ownerIdRoomLuckyBanner']) {
            if (superBox['isPasswordRoomLuckyBanner']) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize! * 0.8),
                        title: const Text(StringManager.enterPassword),
                        content: EnterPasswordRoomDialog(
                          ownerId: superBox['ownerIdRoomLuckyBanner'],
                          myData: MyDataModel.getInstance(),
                        ));
                  });
            } else {
              Navigator.pop(context);
              MainScreen.iskeepInRoom.value = true;
              Navigator.pushNamed(context, Routes.roomHandler,
                  arguments: RoomHandlerPramiter(
                      ownerRoomId: superBox['ownerIdRoomLuckyBanner'], myDataModel: MyDataModel.getInstance()));
            }
          }
        },
        child: ShowLuckyBannerBodyWidget(
            sendDataUser: sendDataUser, coins: superBox['superCoins'], ownerId: superBox['ownerIdRoomLuckyBanner']),
      ),
    );
  }
}
