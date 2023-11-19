// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/host_top_center_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/room_background.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/dialog_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

class BackgroundWidget extends StatefulWidget {

  EnterRoomModel room;
  LayoutMode layoutMode;
  bool isHost;
  BackgroundWidget({super.key, required this.room, required this.layoutMode, required this.isHost});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnRoomBloc, OnRoomStates>(
      builder: (_, state) {
        return Stack(
          children: [
            RoomBackground(room: widget.room,),
            if(widget.layoutMode == LayoutMode.hostTopCenter)
              ValueListenableBuilder<UserDataModel>(
                  valueListenable: RoomScreen.topUserInRoom,
                  builder: (context, topUser, _) {
                    return HostTopCenterWidget(
                      layoutMode: widget.layoutMode,
                      topUser: topUser, room: widget.room,
                      myDataModel: MyDataModel.getInstance(), );
                  }),
            ValueListenableBuilder<bool>(
                valueListenable: PkController.showPK,
                builder: (context, isShowPK, _) {
                  if (isShowPK && widget.layoutMode == LayoutMode.hostTopCenter) {
                    return Padding(
                      padding: EdgeInsets.only(top: AppPadding.p45),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: PKWidget(
                            scoreBlueTeam: PkController.scoreBlue,
                            scoreRedTem: PkController.scoreRed,
                            isHost: widget.isHost,
                            ownerId: widget.room.ownerId.toString(),
                            notifyRoom: activePK,
                          )),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        );
      },
      listener: (_, state) async {
        if (state is UpdateRoomSucsseState) {
          MainScreen.roomData = state.data;
          Navigator.pop(context);
          sucssesToast(context: context, title: StringManager.successfulOperation);
        } else if (state is UpdateRoomErrorState) {
          Navigator.pop(context);
          errorToast(context: context, title: state.errorMassage);
        } else if (state is OnRoomLoadingState) {
          bottomDailog(context: context, widget: const DialogLoadingWidget());
        } else if (state is BanUserFromWritingErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,state.errorMassage));

          // errorToast(context: context, title: state.errorMassage);
        } else if (state is BanUserFromWritingLoadingState) {
          bottomDailog(context: context, widget: const DialogLoadingWidget());
        } else if (state is BanUserFromWritingSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,state.successMassage));

          Navigator.pop(context);
          // sucssesToast(context: context, title: state.successMassage);
        } else if (state is SendPobUpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,state.errorMassage));

          // errorToast(context: context, title: state.errorMassage);
        } else if (state is SendPobUpSuccessState) {
          // sucssesToast(context: context, title: state.successMassage) ;
        } else if (state is SendYallowBannerErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,state.errorMassage));

          // errorToast(context: context, title: state.errorMassage);
        }
      },
    );
  }
}
