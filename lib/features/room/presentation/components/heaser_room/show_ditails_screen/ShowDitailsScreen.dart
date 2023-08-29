
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';




class ShowDitailsScreen extends StatelessWidget {
  final EnterRoomModel roomData;
  final String introRoom;
  final String roomImg;
  final String roomtype ;
  const ShowDitailsScreen({required this.roomData,
    required this.roomImg,
    required this.introRoom,
    required this.roomtype,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize! * 58,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppPadding.p8),
              topLeft: Radius.circular(AppPadding.p8)),
          color: Colors.white),
      padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustoumCachedImage(
                      url: roomImg == ""?ConstentApi().getImage(roomData.roomCover) :
                      ConstentApi().getImage(roomImg),
                      width: ConfigSize.defaultSize! * 15,
                      height: ConfigSize.defaultSize! * 15,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              //live title
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: ColorManager.lightGray,
                    borderRadius: BorderRadius.circular(AppPadding.p10)),
                child: TextField(
                  enabled: false,
                  cursorColor: ColorManager.mainColor,
                  decoration: InputDecoration(
                    hintText: introRoom == ""? roomData.roomIntro:introRoom,
                    hintStyle: const  TextStyle(color: ColorManager.lightGray),
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              const Spacer(
                flex:1,
              ),
              //live catagory
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(StringManager.roomType.tr()),
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                width: ConfigSize.defaultSize! * 9,
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p10, vertical: AppPadding.p6),
                height: AppPadding.p45,
                decoration: BoxDecoration(
                    color: ColorManager.mainColor,
                    border: Border.all(color: ColorManager.lightGray),
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                roomtype ==""?  roomData.roomType! :roomtype,
                  style: const TextStyle(color: ColorManager.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),

              /// save button

              const Spacer(
                flex: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
