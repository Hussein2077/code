// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/diloge_bubel_vip.dart';

class PopUpWidget extends StatelessWidget {
  UserDataModel? ownerDataModel;
  EnterRoomModel enterRoomModel;
  int vip;
  String massage;
  PopUpWidget({super.key, this.ownerDataModel, required this.enterRoomModel, required this.vip, required this.massage});

  @override
  Widget build(BuildContext context) {
    return DilogBubbelVip(
      roomData: enterRoomModel,
      message: massage,
      vip: vip,
      userData: ownerDataModel,
    );
  }
}
