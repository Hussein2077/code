
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_state.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_states.dart';

import 'user_porfile_in_room_body.dart';

// ignore: must_be_immutable
class GeneralRoomProfile extends StatefulWidget {
  GeneralRoomProfile({required this.userId,
    required this.myData,
    required this.roomData,
    required this.layoutMode,
    super.key});

  MyDataModel myData;
  EnterRoomModel roomData;
  String userId;
  LayoutMode layoutMode;

  @override
  State<GeneralRoomProfile> createState() => _GeneralRoomProfileState();
}

class _GeneralRoomProfileState extends State<GeneralRoomProfile> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetUserBloc>(context)
        .add(GetuserEvent(userId: widget.userId));

    return BlocListener<AdminRoomBloc, AdminRoomStates>(
      listener: (context, state) {
        if (state is SuccessAddAdminRoomState) {
          sucssesToast(context: context, title: StringManager.beComeAdmin.tr());
        } else if (state is ErrorAddAdminRoomState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      child: BlocListener<UsersInRoomBloc, OnUserInRoomStates>(
        listener: (context, state) {
          if (state is SuccessKickoutState) {
            sucssesToast(context: context, title: state.successMessage);

            Navigator.pop(context);
          } else if (state is ErrorKickoutState) {
            errorToast(context: context, title: state.errorMessage);
          }
        },
        child: BlocBuilder<GetUserBloc, GetUserState>(
          builder: (context, state) {
            if (state is GetUserLoddingState) {
              return RoomScreen.usersInRoom[widget.userId] == null
                  ? TransparentLoadingWidget(
                height: ConfigSize.defaultSize! * 2,
                width: ConfigSize.defaultSize! * 5.2,
              )
                  : UserProfileInRoom(
                  myData: widget.myData,
                  roomData: widget.roomData,
                  userData: RoomScreen.usersInRoom[widget.userId]!,
                  layoutMode: widget.layoutMode);}
            else if (state is GetUserSucssesState) {
              RoomScreen.usersInRoom
                  .removeWhere((key, value) =>
              key == state.data.id.toString());
              RoomScreen.usersInRoom
                  .putIfAbsent(state.data.id.toString(), () => state.data);


              return UserProfileInRoom(
                  myData: widget.myData,
                  roomData: widget.roomData,
                  userData: state.data,
                  layoutMode: widget.layoutMode);
            }
            else if (state is GetUserErorrState) {
              return InkWell(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2,
                    child: CustomErrorWidget(
                      message: state.error,
                    )),
              );
            } else {
              return RoomScreen.usersInRoom[widget.userId] == null
                  ? TransparentLoadingWidget(
                height: ConfigSize.defaultSize! * 2,
                width: ConfigSize.defaultSize! * 5.2,
              )
                  : UserProfileInRoom(
                myData: widget.myData,
                roomData: widget.roomData,
                userData: RoomScreen.usersInRoom[widget.userId]!,
                layoutMode: widget.layoutMode,
              );
            }
          },
        )


      ),
    );
  }
}
