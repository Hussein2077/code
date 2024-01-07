// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_config.dart';

/// @nodoc
class ZegoSeatBackground extends StatefulWidget {
  final Size size;
  final ZegoUIKitUser? user;
  final Map<String, dynamic> extraInfo;

  final ZegoLiveSeatManager seatManager;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;

  const ZegoSeatBackground({
    Key? key,
    this.user,
    this.extraInfo = const {},
    required this.size,
    required this.seatManager,
    required this.config,
  }) : super(key: key);

  @override
  State<ZegoSeatBackground> createState() => _ZegoSeatForegroundState();
}

/// @nodoc
class _ZegoSeatForegroundState extends State<ZegoSeatBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.config.seatConfig.backgroundBuilder?.call(
              context,
              widget.size,
              ZegoUIKit().getUser(widget.user?.id ?? ''),
              widget.extraInfo,
            ) ??
            Container(color: Colors.transparent),
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
        top: RoomScreen.layoutMode == LayoutMode.party  ? avatarPosTop+15.zH :avatarPosTop+25.zH,
        left: avatarPosLeft+11.zW ,
        child: Image.asset(AssetsPath.lockSeat, width:seatIconWidth , height: seatIconWidth ,),
      );
    }else if(RoomScreen.listOfMuteSeats.containsKey(widget.extraInfo['index'])){
      return  Positioned(
          top:  RoomScreen.layoutMode == LayoutMode.party  ? avatarPosTop+15.zH :
          avatarPosTop+25.zH,
          left: avatarPosLeft+11.zW ,
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
        top: RoomScreen. layoutMode== LayoutMode.party  ? avatarPosTop+15.zH :avatarPosTop+25.zH  ,
        left:  avatarPosLeft+11.zW  ,
        child: Image.asset(AssetsPath.seat, width:seatIconWidth , height: seatIconWidth ,),
      );
    }
  }

}
