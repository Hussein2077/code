import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';
import '../../../../../../core/model/owner_data_model.dart';

class BanFromWrite extends StatelessWidget {
  final UserDataModel userData;
  final EnterRoomModel roomData;

  const BanFromWrite(
      {required this.roomData, required this.userData, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnRoomBloc, OnRoomStates>(
      builder: (context, state) {
        if (state is BanUserFromWritingSuccessState) {

          if (RoomScreen.banedUsers.containsKey(userData.id.toString())) {
            log('unBan'+userData.id.toString());
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<OnRoomBloc>(context)
                        .add(BanUserFromWritingEvent(
                      type: "unBan",
                      ownerId: roomData.ownerId.toString(),
                      userId: userData.id.toString(),
                    ));
                  },
                  child: Icon(Icons.lock_open,
                      color: ColorManager.gray,
                      size: ConfigSize.defaultSize! * 1.8),
                ),
                Text(
                  StringManager.writeUnBan.tr(),
                  style: const TextStyle(
                    color: ColorManager.gray,
                  ),
                ),
              ],
            );
          } else {

            return Column(
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<OnRoomBloc>(context)
                        .add(BanUserFromWritingEvent(
                      type: "ban",
                      ownerId: roomData.ownerId.toString(),
                      userId: userData.id.toString(),
                    ));
                  },
                  child: Icon(Icons.lock,
                      color: ColorManager.gray,
                      size: ConfigSize.defaultSize! * 1.8),
                ),
                Text(
                  StringManager.writeBan.tr(),
                  style: const TextStyle(
                    color: ColorManager.gray,
                  ),
                ),
              ],
            );
          }
        } else {
          if (RoomScreen.banedUsers.containsKey(userData.id.toString())) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<OnRoomBloc>(context)
                        .add(BanUserFromWritingEvent(
                      type: "unBan",
                      ownerId: roomData.ownerId.toString(),
                      userId: userData.id.toString(),
                    ));
                  },
                  child: Icon(Icons.lock_open,
                      color: ColorManager.gray,
                      size: ConfigSize.defaultSize! * 1.8),
                ),
                Text(
                  StringManager.writeUnBan.tr(),
                  style: const TextStyle(
                    color: ColorManager.gray,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    BlocProvider.of<OnRoomBloc>(context)
                        .add(BanUserFromWritingEvent(
                      type: "ban",
                      ownerId: roomData.ownerId.toString(),
                      userId: userData.id.toString(),
                    ));
                  },
                  child: Icon(Icons.lock,
                      color: ColorManager.gray,
                      size: ConfigSize.defaultSize! * 1.8),
                ),
                Text(
                  StringManager.writeBan.tr(),
                  style: const TextStyle(
                    color: ColorManager.gray,
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
