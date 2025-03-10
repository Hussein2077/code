// Dart imports:

// Flutter imports:

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/general_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/anonymous_dialog.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_inner_text.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/audio_room_layout.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/pop_up_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/pop_up_sheet_menu.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_controller.dart';

/// @nodoc
class ZegoSeatForeground extends StatefulWidget {
  final Size size;
  final ZegoUIKitUser? user;
  final Map<String, dynamic> extraInfo;

  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
  final ZegoPopUpManager popUpManager;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;
  final ZegoLiveAudioRoomController? prebuiltController;
  final bool isHost ;
  final EnterRoomModel roomData;
  final Widget? popUpWidget ;

  const ZegoSeatForeground({
    Key? key,
    this.user,
    this.extraInfo = const {},
    this.prebuiltController,
    required this.size,
    required this.seatManager,
    required this.connectManager,
    required this.popUpManager,
    required this.config,
    required this.roomData,
    required this.isHost,
     this.popUpWidget
  }) : super(key: key);

  @override
  State<ZegoSeatForeground> createState() => _ZegoSeatForegroundState();
}

/// @nodoc
class _ZegoSeatForegroundState extends State<ZegoSeatForeground> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
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
            // Positioned(
            //   bottom: 0,
            //   child: userName(context, constraints.maxWidth),
            // ),
            // if (widget.seatManager.isAttributeHost(user))
            //   Positioned(
            //     top: seatItemHeight -
            //         seatUserNameFontSize -
            //         seatHostFlagHeight -
            //         3.zR, //  spacing
            //     child: hostFlag(context, constraints.maxWidth),
            //   )
            // else
            //   Container(),
            // if (widget.seatManager.isCoHost(user))
            //   Positioned(
            //     top: seatItemHeight -
            //         seatUserNameFontSize -
            //         seatHostFlagHeight -
            //         3.zR, //  spacing
            //     child: coHostFlag(context, constraints.maxWidth),
            //   )
            // else
            //   Container(),
            ...null == widget.user ? [] : [
           //microphoneOffFlag()
        ],
          ],
        );
      },
    );
  }
  void onClicked() async {

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
    PopupItem showDetailsItem  =  PopupItem(
      PopupItemValue.showUserDetails,
      StringManager.showDetails.tr(),
      userId: widget.seatManager.getUserByIndex(index)?.id??'',
      index: index,
    );
    PopupItem takeSeatItem =  PopupItem(
      PopupItemValue.takeOnSeat,
      StringManager.takeSeat.tr(),
      userId: MyDataModel.getInstance().id.toString(),
      index: index,
    );




    // check mode room
    if(RoomScreen.layoutMode==LayoutMode.hostTopCenter){

      // first check if seat is empty or not ?
      if (null == widget.user)
      {
        // if seat was locked normal user can not do any thing
        if(RoomScreen.listOfLoskSeats.value.containsKey(index)&&
            !widget.isHost
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
                  popupItems.add( takeSeatItem);
                }
              }


              RoomScreen.listOfMuteSeats.containsKey(index)
                  ? popupItems.add(PopupItem(
                PopupItemValue.unMuteMic,
                StringManager.unMuteMic.tr(),
                index: index,
              ))
                  : popupItems.add(PopupItem(
                PopupItemValue.muteMic,
                StringManager.muteMic.tr(),
                index: index,
              ));
              RoomScreen.listOfLoskSeats.value.containsKey(index)
                  ? popupItems.add(PopupItem(
                PopupItemValue.unLockSeat,
                StringManager.unLockSeat.tr(),
                index: index,
              ))
                  : popupItems.add(PopupItem(
                PopupItemValue.lockSeat,
                StringManager.lockSeat.tr(),
                index: index,
              ));
            }
            else{
              // normal user
              if(!widget.isHost){
                popupItems.add(takeSeatItem);
              }

            }
          }
        }
        else{
          RoomScreen.listOfMuteSeats.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unMuteMic,
            StringManager.unMuteMic.tr(),
            index: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.muteMic,
            StringManager.muteMic.tr(),
            index: index,
          ));
          RoomScreen.listOfLoskSeats.value.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unLockSeat,
            StringManager.unLockSeat.tr(),
            index: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.lockSeat,
            StringManager.lockSeat.tr(),
            index: index,
          ));
          //user is host and seat is empty

        }

      }
      else{
        popupItems.add(showDetailsItem);

        if(widget.seatManager.localIsAHost
            && widget.seatManager.getUserByIndex(index)?.id
                !=widget.roomData.ownerId.toString() ){
          // host can remove any users
          popupItems.add(PopupItem(
            PopupItemValue.takeOffSeat,
            'من علي المقعد${widget.user?.name}حذف'
                .replaceFirst(
              'من علي المقعد${widget.user?.name}حذف',
              'من علي المقعد${widget.user?.name}حذف' ,
            ),
            userId: widget.seatManager.getUserByIndex(index)?.id??'',
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
            userId: widget.seatManager.getUserByIndex(index)?.id??'',
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
          popupItems.add(takeSeatItem);
          RoomScreen.listOfMuteSeats.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unMuteMic,
            StringManager.unMuteMic.tr(),
            index: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.muteMic,
            StringManager.muteMic.tr(),
            index: index,
          ));
          RoomScreen.listOfLoskSeats.value.containsKey(index)
              ? popupItems.add(PopupItem(
            PopupItemValue.unLockSeat,
            StringManager.unLockSeat.tr(),
            index: index,
          ))
              : popupItems.add(PopupItem(
            PopupItemValue.lockSeat,
            StringManager.lockSeat.tr(),
            index: index,
          ));

        }
        else{
          // if seat was locked normal user can not do any thing
          if(RoomScreen.listOfLoskSeats.value.containsKey(index)){
            return ;
          }
          // if you normal user you can just set on seat
          popupItems.add(takeSeatItem);

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
        popupItems.add(showDetailsItem);
        if( -1 !=
            widget.seatManager
                .getIndexByUserID(ZegoUIKit().getLocalUser().id) &&
            widget.seatManager.getUserByIndex(index)!.id.toString() ==
                ZegoUIKit().getLocalUser().id){
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
            index: index,
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
            index: index,
          ));
        }



      }

    }

    if(popupItems.length==1 && popupItems.contains(showDetailsItem)){

      if(widget.seatManager.getUserByIndex(index)!.id.startsWith('-1')){
        bottomDailog(
          widget: const AnonymousDialog(),
          context: context,
        );
      }else{
        bottomDailog(
            context: context,
            widget:
            GeneralRoomProfile(
              myData:MyDataModel.getInstance(),
              userId: widget.seatManager.getUserByIndex(index)?.id??'' ,
              roomData: widget.roomData,
              layoutMode:RoomScreen.layoutMode,
            )

        );
      }


      return ;

    }
      if(popupItems.length ==1 &&  popupItems.contains(takeSeatItem)){
        await  widget.seatManager.takeOnSeat(
          index,
          isForce: false,
          isDeleteAfterOwnerLeft: true,
          ownerId: widget.roomData.ownerId.toString(),
        );

        Future.delayed(const  Duration(seconds: 3),(){
          if(RoomScreen.listOfMuteSeats.containsKey(index)
              ||RoomScreen.usersHasMute.contains(MyDataModel.getInstance().id.toString())){
            ZegoUIKit().turnMicrophoneOn(false,
                userID: MyDataModel.getInstance().id.toString());
            // return true ;
          }
        }) ;
        return ;
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
        roomData: widget.roomData,
        innerText: ZegoInnerText(),
        connectManager: widget.connectManager,
        popUpManager: widget.popUpManager, popUpWidget: widget.popUpWidget
    );
    //!widget.seatManager.isAHostSeat(index)
  }




  // Widget microphoneOffFlag() {
  //   return widget.user?.microphone.value ?? false
  //       ? Container()
  //       : Positioned(
  //           top: avatarPosTop,
  //           left: 0,
  //           right: 0,
  //           child: Container(
  //             width: seatIconWidth,
  //             height: seatIconWidth,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: Colors.black.withOpacity(0.5),
  //             ),
  //             child: PrebuiltLiveAudioRoomImage.asset(
  //               PrebuiltLiveAudioRoomIconUrls.seatMicrophoneOff,
  //             ),
  //           ),
  //         );
  // }
}
