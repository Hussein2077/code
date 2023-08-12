// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';


// Package imports:


// Project imports:
import '../../../../zego_uikit/zego_uikit.dart';
import '../../live_audio_room_config.dart';

class ZegoSeatBackground extends StatefulWidget {
  final Size size;
  final ZegoUIKitUser? user;
  final Map<String, dynamic> extraInfo;

  final ZegoLiveSeatManager seatManager;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;
  final LayoutMode roomMode ;

  const ZegoSeatBackground({
    Key? key,
    this.user,
    this.extraInfo = const {},
    required this.size,
    required this.seatManager,
    required this.config,
    required this.roomMode,
  }) : super(key: key);

  @override
  State<ZegoSeatBackground> createState() => _ZegoSeatForegroundState();
}

class _ZegoSeatForegroundState extends State<ZegoSeatBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<Map<String, String>>(
            valueListenable: ZegoUIKit()
                .getInRoomUserAttributesNotifier(widget.user?.id ?? ''),
            builder: (context, inRoomAttributes, _) {
              return widget.config.seatConfig.backgroundBuilder?.call(
                    context,
                    widget.size,
                    ZegoUIKit().getUser(widget.user?.id ?? ''),
                    widget.extraInfo,
                  ) ??
                  Container(color: Colors.transparent);
            }),
        ...null == widget.user
            ? [
                emptySeat(),
              ]
            : [],
      ],
    );
  }

  Widget emptySeat() {
      // widget.refreshBackground ;
      if(RoomScreen.listOfLoskSeats.value.containsKey(widget.extraInfo['index'])){
        return Positioned(
          top: widget.roomMode == LayoutMode.party  ? avatarPosTop+15.h :avatarPosTop+25.h,
          left: avatarPosLeft+11.w ,
          child: Image.asset(AssetsPath.lockSeat, width:seatIconWidth , height: seatIconWidth ,),
        );
      }else if(RoomScreen.listOfMuteSeats.containsKey(widget.extraInfo['index'])){
        return  Positioned(
            top:  widget.roomMode == LayoutMode.party  ? avatarPosTop+15.h :avatarPosTop+25.h,
            left: avatarPosLeft+11.w ,
            child: Stack(
              children: [
                Image.asset(AssetsPath.seat,width:seatIconWidth , height: seatIconWidth ,),
                Positioned(
                  bottom: AppPadding.p2,
                  left: AppPadding.p2,
                  child: Container(

                    width:  AppPadding.p24,
                    height: AppPadding.p24,
                    decoration:const BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage('assets/icons/muteIcon.png')
                        )
                    ),


                  ),
                )
              ],
            )


        );
      }
      else{
        return Positioned(
          top: widget.roomMode == LayoutMode.party  ? avatarPosTop+15.h :avatarPosTop+25.h  ,
          left:  avatarPosLeft+11.w  ,
          child: Image.asset(AssetsPath.seat, width:seatIconWidth , height: seatIconWidth ,),
        );
      }
    }

  Widget microphoneOffFlag() {
    return ValueListenableBuilder<bool>(
      valueListenable:
      ZegoUIKit().getMicrophoneStateNotifier(widget.user?.id ?? ""),
      builder: (context, isMicrophoneEnabled, _) {
        if (isMicrophoneEnabled) {
          return Container();
        }
        return Positioned(
          top: avatarPosTop+27.h,
          left: avatarPosLeft+14.w,
          child:Stack(
            children: [
              CircleAvatar(
                maxRadius: AppPadding.p26,
                backgroundImage: NetworkImage(ConstentApi()
                    .getImage(
                    RoomScreen.usersInRoom[widget.user!.id]?.profile!.image)),
              ),
              Positioned(
                bottom: AppPadding.p2,
                left: AppPadding.p2,
                child: Container(

                  width:  AppPadding.p24,
                  height: AppPadding.p24,
                  decoration:const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage('assets/images/muteIcon.png')
                      )
                  ),


                ),
              )
            ],
          ),
        );
      },
    );
  }


  }

