// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'dart:ui' as ui;

import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/in_room_message_input.dart';

class ShowYallowBannerWidget extends StatelessWidget {

  AnimationController controllerYallowBanner;
  Animation<Offset> offsetAnimationYallowBanner;
  UserDataModel? senderYallowBanner;
  bool hasPassword;
  MyDataModel myData;
  int ownerId;
  int cureentRoomId;
  ShowYallowBannerWidget({super.key, required this.controllerYallowBanner, required this.offsetAnimationYallowBanner, this.senderYallowBanner, required this.hasPassword, required this.myData, required this.ownerId, required this.cureentRoomId});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: AnimatedBuilder(
          animation: controllerYallowBanner,
          builder: (context, child) {
            return Transform.translate(
                offset: offsetAnimationYallowBanner.value,
                child: InkWell(
                  onTap: () {
                    if (ownerId != cureentRoomId) {
                      Methods().checkIfRoomHasPassword(
                          context: context,
                          isInRoom: true,
                          hasPassword: hasPassword,
                          ownerId: ownerId.toString(),
                          myData: myData);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ConfigSize.defaultSize! - 4,
                          horizontal: ConfigSize.defaultSize! - 3),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: ColorManager.yellowGrident),
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: ConfigSize.defaultSize! * 10),
                      width: ConfigSize.defaultSize! * 35,
                      height: ConfigSize.defaultSize! * 4,
                      child: Row(
                        children: [
                          UserImage(
                              imageSize: ConfigSize.defaultSize! * 4,
                              image: senderYallowBanner!.isAanonymous!
                                  ? StringManager.imageAnanyomus
                                  : senderYallowBanner!.profile!.image!),
                          SizedBox(
                            width: ConfigSize.defaultSize,
                          ),
                          SizedBox(
                            width: ConfigSize.defaultSize! * 23.5,
                            child: TextScroll(
                              textDirection: ui.TextDirection.rtl,

                              senderYallowBanner!.isAanonymous!
                                  ? "${StringManager.nameAnayoums} : ${ZegoInRoomMessageInput.messageYallowBanner}"
                                  : "${senderYallowBanner!.name} : ${ZegoInRoomMessageInput.messageYallowBanner}",
                              mode: TextScrollMode.endless,
                              velocity:
                              const Velocity(pixelsPerSecond: Offset(70, 0)),
                              delayBefore: const Duration(milliseconds: 500),
                              pauseBetween: const Duration(seconds: 1),
                              style: const TextStyle(color: Colors.black),

                              // textAlign: TextAlign.left,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.gray.withOpacity(0.6)),
                            child: IconButton(
                                onPressed: () {
                                  controllerYallowBanner.reset();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 15,
                                )),
                          )
                        ],
                      )),
                ));
          }),
    );
  }
}
