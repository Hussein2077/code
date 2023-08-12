// Dart imports:

// Flutter imports:
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/audio_video/audio_room_layout.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/pop_up_sheet_menu.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';


class ZegoSeatForeground extends StatefulWidget {
  final Size size;
  final ZegoUIKitUser? user;
  final Map<String, dynamic> extraInfo;
  final LayoutMode layoutMode ;
  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;
  final ZegoLiveAudioRoomController? prebuiltController;
  final EnterRoomModel roomData ;
  final bool isHost ;
  final LayoutMode roomMode ;
  final MyDataModel myDataModel ;

  const ZegoSeatForeground({
    Key? key,
    this.user,
    this.extraInfo = const {},
    this.prebuiltController,
    required this.size,
    required this.isHost,
    required this.roomMode,
    required this.seatManager,
    required this.connectManager,
    required this.myDataModel,
    required this.config,
    required this.roomData, required this.layoutMode
  }) : super(key: key);

  @override
  State<ZegoSeatForeground> createState() => _ZegoSeatForegroundState();
}

class _ZegoSeatForegroundState extends State<ZegoSeatForeground> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: ValueListenableBuilder<Map<String, String>>(
        valueListenable:
            ZegoUIKit().getInRoomUserAttributesNotifier(widget.user?.id ?? ''),
        builder: (context, inRoomAttributes, _) {
          return Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                widget.config.seatConfig.foregroundBuilder?.call(
                      context,
                      widget.size,
                      ZegoUIKit().getUser(widget.user?.id ?? ''),
                      widget.extraInfo,
                    ) ??
                    foreground(
                      context,
                      widget.size,
                      ZegoUIKit().getUser(widget.user?.id ?? ''),
                      widget.extraInfo,
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget foreground(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              child: userName(context, constraints.maxWidth),
            ),
            if (widget.seatManager.isAttributeHost(user))
              Positioned(
                top: seatItemHeight -
                    seatUserNameFontSize -
                    seatHostFlagHeight -
                    3.r, //  spacing
                child: hostFlag(context, constraints.maxWidth),
              )
            else
              Container(),
        //    ...null == widget.user ? [Container(width: 30,height: 30,color: Colors.red,)] : [Container(width: 30,height: 30,color: Colors.blue,)],
          ],
        );
      },
    );
  }

  void onClicked() {
    var index =
        int.tryParse(widget.extraInfo[layoutGridItemIndexKey].toString()) ?? -1;
    if (-1 == index) {
      ZegoLoggerService.logInfo(
        "ERROR!!! click seat index is invalid",
        tag: "audio room",
        subTag: "foreground",
      );
      return;
    }
    List<PopupItem> popupItems = [];

    // check mode room
    if(widget.roomMode==LayoutMode.hostTopCenter){

      // first check if seat is empty or not ?
      if (null == widget.user)
      {
        // if seat was locked normal user can not do any thing
        if(RoomScreen.listOfLoskSeats.value.containsKey(index)&& !widget.isHost
            &&!RoomScreen.adminsInRoom.containsKey(ZegoUIKit().getLocalUser().id)){
          return ;
        }
        // empty seat
        /// forbid host switch seat and speaker/audience take locked seat
        if (!widget.seatManager.localIsAHost &&
            !widget.seatManager.isAHostSeat(index))
        {

          if (-1 !=
              widget.seatManager
                  .getIndexByUserID(ZegoUIKit().getLocalUser().id) &&
              !RoomScreen.adminsInRoom.containsKey(ZegoUIKit().getLocalUser().id)&&!widget.isHost) {
            //check if user on seat or not
            /// local user is on seat
            widget.seatManager.switchToSeat(index);
          }
          else{
            // user is not on seat
            // check if normal user or admin && host
            if(RoomScreen.adminsInRoom.containsKey(ZegoUIKit().getLocalUser().id)||widget.isHost)
            {
              // local user is not on seat

              if(!widget.isHost){
                if(!widget.seatManager.localIsAHost){
                  popupItems.add(PopupItem(
                    PopupItemValue.takeOnSeat,
                    StringManager.takeSeat.tr(),
                    data: index,
                  ));
                }
              }


              RoomScreen.listOfMuteSeats.containsKey(index)
                  ? popupItems.add(PopupItem(
                PopupItemValue.unMuteMic,
                StringManager.unMuteMic.tr(),
                data: index,
              ))
                  : popupItems.add(PopupItem(
                PopupItemValue.muteMic,
                StringManager.muteMic.tr(),
                data: index,
              ));
              RoomScreen.listOfLoskSeats.value.containsKey(index)
                  ? popupItems.add(PopupItem(
                PopupItemValue.unLoackSeat,
                StringManager.unLockSeat.tr(),
                data: index,
              ))
                  : popupItems.add(PopupItem(
                PopupItemValue.lockSeat,
                StringManager.lockSeat.tr(),
                data: index,
              ));
            }
            else{
              // normal user
              log("777777777777777777777777777777777777777777777777111111111111");
              if(!widget.isHost){
                log("7777777777777777777777777777777777777777777777772222222");
                popupItems.add(PopupItem(
                  PopupItemValue.takeOnSeat,
                  StringManager.takeSeat.tr(),
                  data: index,
                ));
              }

            }
          }
        }
        else{
          RoomScreen.listOfMuteSeats.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unMuteMic,
            StringManager.unMuteMic.tr(),
            data: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.muteMic,
            StringManager.muteMic.tr(),
            data: index,
          ));
          RoomScreen.listOfLoskSeats.value.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unLoackSeat,
            StringManager.unLockSeat.tr(),
            data: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.lockSeat,
            StringManager.lockSeat.tr(),
            data: index,
          ));
          //user is host and seat is empty

        }

      }
      else{
        popupItems.add(PopupItem(
          PopupItemValue.showUserDetails,
          StringManager.showDetails.tr(),
          data: widget.seatManager.getUserByIndex(index)?.id,
        ));

        if(widget.seatManager.localIsAHost
            && widget.seatManager.getUserByIndex(index)?.id !=widget.roomData.ownerId.toString() ){
          // host can remove any users
          popupItems.add(PopupItem(
            PopupItemValue.takeOffSeat,
            'من علي المقعد${widget.user?.name}حذف'
                .replaceFirst(
              'من علي المقعد${widget.user?.name}حذف',
              'من علي المقعد${widget.user?.name}حذف' ,
            ),
            data: index,
          ));
        }

        if(RoomScreen.adminsInRoom.containsKey(ZegoUIKit().getLocalUser().id)&&
            !widget.seatManager.isAHostSeat(index)
            &&!RoomScreen.adminsInRoom.containsKey(widget.seatManager.getUserByIndex(index)!.id.toString())&&
            !(ZegoUIKit().getLocalUser().id ==
                widget.seatManager.getUserByIndex(index)?.id)
        ){
          // admin can  just remove normal user && and can not remove them self
          popupItems.add(PopupItem(
            PopupItemValue.takeOffSeat,
            'من علي المقعد${widget.user?.name}حذف'
                .replaceFirst(
              'من علي المقعد${widget.user?.name}حذف',
              ' من علي المقعد${widget.user?.name}حذف ',
            ),
            data: index,
          )) ;
        }



      }

      if (ZegoUIKit().getLocalUser().id ==
          widget.seatManager.getUserByIndex(index)?.id &&
          !widget.isHost){

        /// speaker can local leave seat , && !host
        popupItems.add(PopupItem(
          PopupItemValue.leaveSeat,
          StringManager.areYouSureLeaveSeat.tr(),
        ));


      }


    }
    else{

      // first check if seat is empty or not ?
      if (null == widget.user)
      {
        //check if you is host or admin ,than you can do any think
        if(RoomScreen.adminsInRoom.containsKey(ZegoUIKit().getLocalUser().id)||widget.isHost){
          popupItems.add(PopupItem(
            PopupItemValue.takeOnSeat,
            StringManager.takeSeat.tr(),
            data: index,
          ));
          RoomScreen.listOfMuteSeats.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unMuteMic,
            StringManager.unMuteMic.tr(),
            data: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.muteMic,
            StringManager.muteMic.tr(),
            data: index,
          ));
          RoomScreen.listOfLoskSeats.value.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unLoackSeat,
            StringManager.unLockSeat.tr(),
            data: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.lockSeat,
            StringManager.lockSeat.tr(),
            data: index,
          ));

        }
        else{
          // if seat was locked normal user can not do any thing
          if(RoomScreen.listOfLoskSeats.value.containsKey(index)){
            return ;
          }
          // if you normal user you can just set on seat
          popupItems.add(PopupItem(
            PopupItemValue.takeOnSeat,
            StringManager.takeSeat.tr(),
            data: index,
          ));

          if(-1 !=
              widget.seatManager
                  .getIndexByUserID(ZegoUIKit().getLocalUser().id)){
            // if normal user already on seat
            widget.seatManager.switchToSeat(index);
            return ;
          }
        }


      }
      else{
        //seat not empty

        //first to any user in room can show userDetails
        popupItems.add(PopupItem(
          PopupItemValue.showUserDetails,
          StringManager.showDetails.tr(),
          data: widget.seatManager.getUserByIndex(index)?.id,
        ));
       if( -1 !=
            widget.seatManager
                .getIndexByUserID(ZegoUIKit().getLocalUser().id) &&
           widget.seatManager.getUserByIndex(index)!.id.toString() == widget.myDataModel.id.toString() ){
         popupItems.add(PopupItem(
           PopupItemValue.leaveSeat,
           StringManager.areYouSureLeaveSeat.tr(),
         ));
       }

   
        if(widget.isHost ){
          // host can remove any users
          popupItems.add(PopupItem(
            PopupItemValue.takeOffSeat,
            'من علي المقعد${widget.user?.name}حذف'
                .replaceFirst(
              'من علي المقعد${widget.user?.name}حذف',
              'من علي المقعد${widget.user?.name}حذف' ,
            ),
            data: index,
          ));
        }
        //check if you admin or not && check if user that you will remove him is host or is admin
        if(RoomScreen.adminsInRoom.containsKey(ZegoUIKit().getLocalUser().id) &&
            widget.seatManager.getUserByIndex(index)!.id.toString() !=widget.roomData.ownerId.toString()
            &&!RoomScreen.adminsInRoom.containsKey(widget.seatManager.getUserByIndex(index)!.id.toString())&&
            !(ZegoUIKit().getLocalUser().id ==
                widget.seatManager.getUserByIndex(index)?.id)
        ){


          // admin can  just remove normal user && and can not remove them self
          popupItems.add(PopupItem(
            PopupItemValue.takeOffSeat,
            'من علي المقعد${widget.user?.name}حذف'
                .replaceFirst(
              'من علي المقعد${widget.user?.name}حذف',
              ' من علي المقعد${widget.user?.name}حذف ',
            ),
            data: index,
          ));
        }



      }

    }

    if (popupItems.isEmpty) {
      return;
    }

    popupItems.add(PopupItem(
      PopupItemValue.cancel,
      StringManager.cancle.tr(),
    ));

    showPopUpSheet(
        context: context,
        userID: widget.user?.id ?? "",
        popupItems: popupItems,
        seatManager: widget.seatManager,
        myDataModel: widget.myDataModel,
        roomData: widget.roomData,
        innerText: ZegoInnerText(),
        connectManager: widget.connectManager,
        layoutMode: widget.layoutMode
    );
    //!widget.seatManager.isAHostSeat(index)
  }
 //zego logic
 //  void onClicked() {
 //    final index =
 //        int.tryParse(widget.extraInfo[layoutGridItemIndexKey].toString()) ?? -1;
 //    if (-1 == index) {
 //      ZegoLoggerService.logInfo(
 //        'ERROR!!! click seat index is invalid',
 //        tag: 'audio room',
 //        subTag: 'foreground',
 //      );
 //      return;
 //    }
 //
 //    if (widget.config.onSeatClicked != null) {
 //      ZegoLoggerService.logInfo(
 //        'ERROR!!! click seat event is deal outside',
 //        tag: 'audio room',
 //        subTag: 'foreground',
 //      );
 //
 //      widget.config.onSeatClicked!.call(index, widget.user);
 //      return;
 //    }
 //
 //    final popupItems = <PopupItem>[];
 //
 //    if (null == widget.user) {
 //      /// empty seat
 //      /// forbid host switch seat and speaker/audience take locked seat
 //      if (!widget.seatManager.localIsAHost &&
 //          !widget.seatManager.isAHostSeat(index)) {
 //        if (-1 !=
 //            widget.seatManager
 //                .getIndexByUserID(ZegoUIKit().getLocalUser().id)) {
 //          /// local user is on seat
 //          widget.seatManager.switchToSeat(index);
 //        } else {
 //          /// local user is not on seat
 //          if (!widget.seatManager.isSeatLockedNotifier.value) {
 //            /// only seat is not locked
 //            /// if locked, can't apply by click seat
 //            popupItems.add(PopupItem(
 //              PopupItemValue.takeOnSeat,
 //              widget.config.innerText.takeSeatMenuButton,
 //              data: index,
 //            ));
 //          }
 //        }
 //      }
 //    } else {
 //      /// have a user on seat
 //      if (ZegoLiveAudioRoomRole.host == widget.seatManager.localRole.value &&
 //          widget.user?.id != ZegoUIKit().getLocalUser().id) {
 //        popupItems
 //
 //          /// host can kick others off seat
 //          ..add(PopupItem(
 //            PopupItemValue.takeOffSeat,
 //            widget.config.innerText.removeSpeakerMenuDialogButton.replaceFirst(
 //              widget.config.innerText.param_1,
 //              widget.user?.name ?? '',
 //            ),
 //            data: index,
 //          ))
 //
 //          /// host can mute others
 //          ..add(PopupItem(
 //            PopupItemValue.muteSeat,
 //            widget.config.innerText.muteSpeakerMenuDialogButton.replaceFirst(
 //              widget.config.innerText.param_1,
 //              widget.user?.name ?? '',
 //            ),
 //            data: index,
 //          ));
 //      } else if (ZegoUIKit().getLocalUser().id ==
 //              widget.seatManager.getUserByIndex(index)?.id &&
 //          ZegoLiveAudioRoomRole.host != widget.seatManager.localRole.value) {
 //        /// speaker can local leave seat
 //        popupItems.add(PopupItem(
 //          PopupItemValue.leaveSeat,
 //          widget.config.innerText.leaveSeatDialogInfo.title,
 //        ));
 //      }
 //    }
 //
 //    if (popupItems.isEmpty) {
 //      return;
 //    }
 //
 //    popupItems.add(PopupItem(
 //      PopupItemValue.cancel,
 //      widget.config.innerText.cancelMenuDialogButton,
 //    ));
 //
 //    showPopUpSheet(
 //      context: context,
 //      userID: widget.user?.id ?? '',
 //      popupItems: popupItems,
 //      seatManager: widget.seatManager,
 //      connectManager: widget.connectManager,
 //      innerText: widget.config.innerText,
 //      roomData: widget.roomData,
 //    );
 //  }

  Widget hostFlag(BuildContext context, double maxWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(maxWidth, seatHostFlagHeight)),
      child: Center(
        child: PrebuiltLiveAudioRoomImage.asset(
          PrebuiltLiveAudioRoomIconUrls.seatHost,
        ),
      ),
    );
  }

  Widget userName(BuildContext context, double maxWidth) {
    return SizedBox(
      width: maxWidth,
      child: Text(
        widget.user?.name ?? '',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: seatUserNameFontSize,
          color: Colors.black,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }


}
