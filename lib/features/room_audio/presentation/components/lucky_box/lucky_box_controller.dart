// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/error_luck_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/sucess_luck_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';

class LuckyBoxData {
  final String boxId;
  final String coinns;
  final String ownerBoxId;
  final String ownerName;
  final TypeLuckyBox typeLuckyBox;
  final int remTime;
  final String uId;
  final String ownerImage;

  LuckyBoxData(
      {required this.boxId,
        required this.uId,
        required this.ownerImage,
        required this.coinns,
        required this.ownerName,
        required this.ownerBoxId,
        required this.typeLuckyBox,
        required this.remTime});
}

class LuckyBoxVariables{
  static String typeBox = "luckyBox";
  static String bannerSuperBoxKey = 'bannerSuperBox';
  static ValueNotifier<int> updateLuckyBox = ValueNotifier<int>(0);
  static StreamController<List<LuckyBoxData>> luckyBoxAddecontroller = StreamController.broadcast();
  static StreamController<List<LuckyBoxData>> luckyBoxRemovecontroller = StreamController.broadcast();
  static ValueNotifier<bool> showBannerLuckyBox = ValueNotifier<bool>(false);

  static Map<String, dynamic> luckyBoxMap = {
    "luckyBoxes": <LuckyBoxData>[],
    "coins": "0",
    "quantity": "25",
    "currentBox": 1
  };

  static UserDataModel? sendSuperBox;
}

BickFromLuckyBox(Map<String, dynamic> result, BuildContext context){
  ZegoUIKit().sendInRoomMessage(result[messageContent]['res'], false);
  if (result[messageContent]['succ']) {
    LuckyBoxVariables.luckyBoxMap['luckyBoxes'].removeAt(LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1);
    LuckyBoxVariables.luckyBoxRemovecontroller.add(LuckyBoxVariables.luckyBoxMap['luckyBoxes']);

    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: SucessLuckWidget(
              coins: result[messageContent]['co'].toString(),
            ),
          );
        });
  } else {
    Navigator.pop(context);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: ErrorLuckWidget(
                isNotLucky: false,
              ));
        });
  }
}

BannerSuperBoxKey(Map<String, dynamic> result, var superBox, var sendSuperBox)async{
  UserDataModel sendBox;
  if (RoomScreen.usersInRoom[result[messageContent]["ownerBoxid"].toString()] == null) {
    sendBox = await RemotlyDataSourceProfile().getUserData(userId: result[messageContent]["ownerBoxid"].toString());
  } else {
    sendBox = RoomScreen.usersInRoom[result[messageContent]["ownerBoxid"].toString()]!;
  }
  superBox['isPasswordRoomLuckyBanner'] = result[messageContent]["isRoomPassword"];
  superBox['superCoins'] = result[messageContent]["coins"].toString();
  sendSuperBox = sendBox;
  superBox['ownerIdRoomLuckyBanner'] = result[messageContent]["ownerRoomId"].toString();
  LuckyBoxVariables.showBannerLuckyBox.value = true;
}

show_lucky_box(Map<String, dynamic> result){
  LuckyBoxData luckyBox = LuckyBoxData(
      boxId: result[messageContent][boxIDKey].toString(),
      coinns: result[messageContent][boxCoinsKey].toString(),
      ownerBoxId: result[messageContent][ownerBoxIdKey].toString(),
      ownerName: result[messageContent][ownerBoxNameKey],
      typeLuckyBox: result[messageContent][boxTypeKey] == 'normal'
          ? TypeLuckyBox.normalBox
          : TypeLuckyBox.superBox,
      uId: result[messageContent]['ownerBoxUId'],
      ownerImage: result[messageContent]['ownerBoxImage'] ?? '',
      remTime: 30);
  LuckyBoxVariables.luckyBoxMap['luckyBoxes'].add(luckyBox);

  LuckyBoxVariables.luckyBoxAddecontroller.add(LuckyBoxVariables.luckyBoxMap['luckyBoxes']);
}

hide_lucky_box(Map<String, dynamic> result){
  LuckyBoxVariables.luckyBoxMap['luckyBoxes'].removeWhere((element) => element.boxId == result[messageContent][boxIDKey].toString());
}
