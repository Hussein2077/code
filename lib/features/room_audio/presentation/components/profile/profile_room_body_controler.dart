import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/widgets/report_dailog_for_users.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/message/input_board.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_inner_text.dart';

bool checkIsUserOnMic(UserDataModel userData) {
  bool isOnMic = false;
  RoomScreen.userOnMics.value.forEach((key, value) {
    if (RoomScreen.usersInRoom.containsKey(userData.id.toString())) {
      if (userData.id.toString() == value.id) {
        isOnMic = true;
      }
    }
  });
  return isOnMic;
}

bool cheakisAdminOrHost(
    UserDataModel userData, MyDataModel myData, EnterRoomModel roomData) {
  bool isAdminORHost =
      ((userData.id != myData.id && userData.id != roomData.ownerId) &&
          (RoomScreen.adminsInRoom.containsKey(myData.id) ||
              myData.id == roomData.ownerId));
  return isAdminORHost;
}

bool myProfileOrNot(
  UserDataModel userData,
  MyDataModel myData,
) {
  if (userData.id == myData.id) {
    return true;
  } else {
    return false;
  }
}

void mentionAction(
    {required UserDataModel userData,
    required EnterRoomModel roomData,
    required BuildContext context}) {
  String name = userData.name!.replaceAll(" ", "_");
  Navigator.pop(context);
  Navigator.of(context).push(ZegoInRoomMessageInputBoard(
      roomData: roomData,
      mention:  "@$name",
    innerText: ZegoInnerText(),
       ));
}

void repoertsAction(
    {required UserDataModel userData, required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      builder: (context) {
        return ReportDialogForUsers(
          userID: userData.id.toString(),
        );
      });
}

void banFromWriteAction(
    {required UserDataModel userData,
    required BuildContext context,
    required EnterRoomModel roomData}) {
  if (RoomScreen.banedUsers.containsKey(userData.id.toString())) {
    BlocProvider.of<OnRoomBloc>(context).add(BanUserFromWritingEvent(
      type: "unBan",
      ownerId: roomData.ownerId.toString(),
      userId: userData.id.toString(),
    ));
  } else {
    BlocProvider.of<OnRoomBloc>(context).add(BanUserFromWritingEvent(
      type: "ban",
      ownerId: roomData.ownerId.toString(),
      userId: userData.id.toString(),
    ));
  }
}
