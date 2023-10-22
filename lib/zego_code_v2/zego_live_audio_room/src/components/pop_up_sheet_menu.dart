// Dart imports:

// Flutter imports:

import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
 
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/general_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';



// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_inner_text.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import '../../../zego_uikit/zego_uikit.dart';


class ZegoPopUpSheetMenu extends StatefulWidget {
  const ZegoPopUpSheetMenu({
    Key? key,
    required this.popupItems,
    required this.roomData,
    required this.innerText,
    required this.seatManager,
    required this.connectManager,
    required this.myDataModel,
    required this.layoutMode,
    this.onPressed,
  }) : super(key: key);

  final List<PopupItem> popupItems;
  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
 final  EnterRoomModel roomData ;
  final void Function(PopupItemValue)? onPressed;
  final ZegoInnerText innerText;
  final MyDataModel myDataModel ;
  final LayoutMode layoutMode ;

  @override
  State<ZegoPopUpSheetMenu> createState() => _ZegoPopUpSheetMenuState();
}

class _ZegoPopUpSheetMenuState extends State<ZegoPopUpSheetMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.popupItems.length,
          itemBuilder: (context, index) {
            final popupItem = widget.popupItems[index];
            return popUpItemWidget(index, popupItem);
          },
        ),
      );
    });
  }

  Widget popUpItemWidget(int index, PopupItem popupItem) {
    return GestureDetector(
      onTap: () async {
        ZegoLoggerService.logInfo(
          'click ${popupItem.text}',
          tag: 'audio room',
          subTag: 'pop-up sheet',
        );

        Navigator.of(context).pop();

        switch (popupItem.value) {
          case PopupItemValue.takeOnSeat:
            // i do not use this condation
          await  widget.seatManager.takeOnSeat(
              popupItem.data as int,
              isForce: false,
              isDeleteAfterOwnerLeft: true,
              owerId: widget.roomData.ownerId.toString(),
            );

          Future.delayed(const  Duration(seconds: 5),(){
            if(RoomScreen.listOfMuteSeats.containsKey(popupItem.data)
                ||RoomScreen.usersHasMute.contains(widget.myDataModel.id.toString())){
              ZegoUIKit().turnMicrophoneOn(false,userID: widget.myDataModel.id.toString());
              // return true ;
            }
          }) ;



            break;
          case PopupItemValue.takeOffSeat:
            // clear popup sheet info
            widget.seatManager
                .setKickSeatDialogInfo(KickSeatDialogInfo.empty());
            await widget.seatManager.kickSeat(popupItem.data as int);
            break;
          case PopupItemValue.leaveSeat:
            await widget.seatManager.leaveSeat(showDialog: true);
            break;
          case PopupItemValue.showUserDetails:
            return bottomDailog(
                context: context,
                widget: 
                GeneralRoomProfile(
                  myData: widget.myDataModel,
                  userId:popupItem.data ,
                  roomData: widget.roomData,
                  layoutMode:widget.layoutMode ,
                )

            );
          case  PopupItemValue.lockSeat :
            BlocProvider.of<OnRoomBloc>(context)
                .add(LockMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position: popupItem.data.toString()));
            RoomScreen.listOfLoskSeats.value.putIfAbsent(popupItem.data, () => popupItem.data);
            break;
          case PopupItemValue.unLoackSeat :
            BlocProvider.of<OnRoomBloc>(context)
                .add(UnLockMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position: popupItem.data.toString()));
            RoomScreen.listOfLoskSeats.value.remove(popupItem.data);
            break ;
          case PopupItemValue.muteMic :
            BlocProvider.of<OnRoomBloc>(context)
                .add(MuteMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position:popupItem.data.toString()));
            RoomScreen.listOfMuteSeats.putIfAbsent(popupItem.data, () => popupItem.data);
            break ;
          case PopupItemValue.unMuteMic :
            BlocProvider.of<OnRoomBloc>(context)
                .add(UnMuteMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position:popupItem.data.toString()));
            RoomScreen.listOfMuteSeats.remove(popupItem.data);

            break ;
          case PopupItemValue.muteSeat:
            await widget.seatManager.muteSeat(popupItem.data as int);
            break;
          case PopupItemValue.inviteLink:
            await widget.connectManager.inviteAudienceConnect(
                ZegoUIKit().getUser(popupItem.data as String? ?? '') ??
                    ZegoUIKitUser.empty());
            break;

          case PopupItemValue.cancel:
            break;
        }

        widget.onPressed?.call(popupItem.value);
      },
      child: Container(
        width: double.infinity,
        height: 100.r,
        decoration: BoxDecoration(
          border: (index == (widget.popupItems.length - 1))
              ? null
              : const Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
        ),
        child: Center(
          child: Text(
            popupItem.text,
            style: TextStyle(
              fontSize: 28.r,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void showPopUpSheet({
  required String userID,
  required BuildContext context,
  required List<PopupItem> popupItems,
  required ZegoInnerText innerText,
  required ZegoLiveSeatManager seatManager,
  required ZegoLiveConnectManager connectManager,
  required EnterRoomModel roomData ,
  required  MyDataModel myDataModel,
  required LayoutMode layoutMode
}) {
  seatManager.setPopUpSheetVisible(true);

  final takeOffSeatItemIndex = popupItems
      .indexWhere((popupItem) => popupItem.value == PopupItemValue.takeOffSeat);
  if (-1 != takeOffSeatItemIndex) {
    /// seat user leave, will auto pop this sheet
    seatManager.setKickSeatDialogInfo(
      KickSeatDialogInfo(
        userIndex: popupItems[takeOffSeatItemIndex].data as int,
        userID: userID,
      ),
    );
  }

  showModalBottomSheet(
    barrierColor: ZegoUIKitDefaultTheme.viewBarrierColor,
    backgroundColor: ColorManager.deeporang,
    //ZegoUIKitDefaultTheme.viewBackgroundColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0.r),
        topRight: Radius.circular(32.0.r),
      ),
    ),
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 50),
        child: Container(
          height: (popupItems.length * 101).r,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: ZegoPopUpSheetMenu(
            popupItems: popupItems,
            innerText: innerText,
            seatManager: seatManager,
            connectManager: connectManager, roomData: roomData,
            myDataModel: myDataModel, layoutMode: layoutMode  ,
          ),
        ),
      );
    },
  ).whenComplete(() {
    final takeOffSeatItemIndex = popupItems.indexWhere(
        (popupItem) => popupItem.value == PopupItemValue.takeOffSeat);
    if (-1 != takeOffSeatItemIndex) {
      /// clear kickSeatDialogInfo
      if (seatManager.kickSeatDialogInfo.isExist(
        userID: seatManager.seatsUserMapNotifier
                .value[seatManager.kickSeatDialogInfo.userIndex.toString()] ??
            '',
        userIndex: seatManager.kickSeatDialogInfo.userIndex,
        allSame: true,
      )) {
        ZegoLoggerService.logInfo(
          'clear seat dialog info when popup sheet complete',
          tag: 'audio room',
          subTag: 'seat manager',
        );
        seatManager.kickSeatDialogInfo.clear();
      }
    }

    seatManager.setPopUpSheetVisible(false);
  });
}
