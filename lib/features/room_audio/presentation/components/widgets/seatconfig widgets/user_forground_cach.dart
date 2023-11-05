// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';

class UserForgroundCach extends StatelessWidget {
  ZegoUIKitUser? user;
  UserForgroundCach({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      if (user!.inRoomAttributes.value['frm'].toString() != "0"
          &&user!.inRoomAttributes.value['frm'] != null )
       Positioned(
           top: -22.zR,
           left: -10.zR,
           right: -10.zR,
           bottom: -4.zR,
           child: ShowSVGA(
             imageId: '${user!.inRoomAttributes.value['frm']}$cacheFrameKey',
             url: user!.inRoomAttributes.value['f2'] ?? "",
           )) ,
      ValueListenableBuilder<int>(
          valueListenable: RoomScreen.updateEmojie,
          builder: (context, mapEmoji, _) {
            if (RoomScreen.listOfEmojie.value.containsKey(user!.id)) {
              return   ShowSVGA(
                imageId:
                '${RoomScreen.listOfEmojie.value[user!.id]!.emojieId.toString()}$cacheEmojieKey',
                url: RoomScreen.listOfEmojie.value[user!.id]!.emojie,
              );
            } else {
              return Container();
            }
          }),
      Align(
       alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: ConfigSize.defaultSize! * 20,
          height: ConfigSize.defaultSize! *1.5,
          child: GradientTextVip(
            text: user!.name,
            isVip: user!.inRoomAttributes.value['vip'] == ''
                ? false
                : user!.inRoomAttributes.value['vip'] == '8'
                ? true
                : false,
            textStyle: TextStyle(
              fontSize: AppPadding.p10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),

    ]);
  }
}
