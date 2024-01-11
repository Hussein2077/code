// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/general_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/anonymous_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/pop_up_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_inner_text.dart';

/// @nodoc
class ZegoPopUpSheetMenu extends StatefulWidget {
  const ZegoPopUpSheetMenu({
    Key? key,
    required this.popupItems,
    required this.innerText,
    required this.seatManager,
    required this.connectManager,
    required this.roomData,
     this.popUpWidget,
    this.onPressed,
  }) : super(key: key);

  final List<PopupItem> popupItems;
  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
  final EnterRoomModel roomData ;
  final void Function(PopupItemValue)? onPressed;
  final ZegoInnerText innerText;
  final Widget? popUpWidget ;

  @override
  State<ZegoPopUpSheetMenu> createState() => _ZegoPopUpSheetMenuState();
}

/// @nodoc
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
            return popUpItemWidget(index, popupItem,);
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

        Navigator.of(
          context,
          rootNavigator: widget.seatManager.config.rootNavigator,
        ).pop();

        switch (popupItem.value) {
          case PopupItemValue.takeOnSeat:
          // i do not use this condation
            await  widget.seatManager.takeOnSeat(
              popupItem.index ,
              isForce: false,
              isDeleteAfterOwnerLeft: true,
              ownerId: widget.roomData.ownerId.toString(),
            );

            Future.delayed(const  Duration(seconds: 5),(){
              if(RoomScreen.listOfMuteSeats.containsKey(popupItem.index)
                  ||RoomScreen.usersHasMute.contains(MyDataModel.getInstance().id.toString())){
                ZegoUIKit().turnMicrophoneOn(false,
                    userID: MyDataModel.getInstance().id.toString());
                // return true ;
              }
            }) ;



            break;
          case PopupItemValue.takeOffSeat:
          // clear popup sheet info
            widget.seatManager
                .setKickSeatDialogInfo(KickSeatDialogInfo.empty());
            await widget.seatManager.kickSeat(popupItem.index , popupItem.userId);
            break;
          case PopupItemValue.leaveSeat:
            await widget.seatManager.leaveSeat(showDialog: true);
            break;
          case PopupItemValue.showUserDetails:
            return  popupItem.userId.startsWith('-1')?
            bottomDailog(
              widget: const AnonymousDialog(),
              context: context,
            ):
             bottomDailog(
                context: context,
                widget:
                GeneralRoomProfile(
                  myData: MyDataModel.getInstance(),
                  userId:popupItem.userId ,
                  roomData: widget.roomData,
                  layoutMode:RoomScreen.layoutMode ,
                )

            );
          case  PopupItemValue.lockSeat :
            BlocProvider.of<OnRoomBloc>(context)
                .add(LockMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position: popupItem.index.toString()));
            RoomScreen.listOfLoskSeats.value.putIfAbsent(popupItem.index,
                    () => popupItem.index);
            break;
          case PopupItemValue.unLockSeat :
            BlocProvider.of<OnRoomBloc>(context)
                .add(UnLockMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position: popupItem.index.toString()));
            RoomScreen.listOfLoskSeats.value.remove(popupItem.index);
            break ;
          case PopupItemValue.muteMic :
            BlocProvider.of<OnRoomBloc>(context)
                .add(MuteMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position:popupItem.index.toString()));
            RoomScreen.listOfMuteSeats.putIfAbsent(popupItem.index, () => popupItem.index);
            break ;
          case PopupItemValue.unMuteMic :
            BlocProvider.of<OnRoomBloc>(context)
                .add(UnMuteMicEvent(ownerId: widget.roomData.ownerId.toString(),
                position:popupItem.index.toString()));
            RoomScreen.listOfMuteSeats.remove(popupItem.index);
            break ;
          case PopupItemValue.inviteLink:
            await widget.connectManager.inviteAudienceConnect(
                ZegoUIKit().getUser(popupItem.index as String? ?? ''));
            break;

          case PopupItemValue.cancel:
            break;
        }

        widget.onPressed?.call(popupItem.value);
      },
      child: widget.popUpWidget?? Container(
        width: double.infinity,
        height: 100.zR,
        // color: ColorManager.orang,
        decoration: BoxDecoration(
          border: (index == (widget.popupItems.length - 1))
              ? null
              : Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
        ),
        child: Center(
          child: Text(
            popupItem.text,
            style: TextStyle(
              fontSize: 28.zR,
              fontWeight: FontWeight.w400,
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
  required ZegoPopUpManager popUpManager,
  required EnterRoomModel roomData,
  required Widget?  popUpWidget
}) {
  final key = DateTime.now().millisecondsSinceEpoch;
  popUpManager.addAPopUpSheet(key);

  seatManager.setPopUpSheetVisible(true);

  final takeOffSeatItemIndex = popupItems
      .indexWhere((popupItem) => popupItem.value == PopupItemValue.takeOffSeat);
  if (-1 != takeOffSeatItemIndex) {
    /// seat user leave, will auto pop this sheet
    seatManager.setKickSeatDialogInfo(
      KickSeatDialogInfo(
        userIndex: popupItems[takeOffSeatItemIndex].index ,
        userID: userID,
      ),
    );
  }

  showModalBottomSheet(
    barrierColor:const Color(0xff171821).withOpacity(0.4),
    backgroundColor:  ColorManager.orang,
    //ZegoUIKitDefaultTheme.viewBackgroundColor,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0.zR),
        topRight: Radius.circular(32.0.zR),
      ),
    ),
    isDismissible: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 50),
        child: Container(
          height: (popupItems.length * 101).zR,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: ZegoPopUpSheetMenu(
            popupItems: popupItems,
            innerText: innerText,
            seatManager: seatManager,
            connectManager: connectManager,
            roomData : roomData, popUpWidget:popUpWidget ,
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

    popUpManager.removeAPopUpSheet(key);
    seatManager.setPopUpSheetVisible(false);
  });
}
