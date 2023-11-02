// Flutter imports:
// ignore_for_file: tinvalid_null_aware_operator

// Flutter imports:

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';

// Package imports:
import 'package:tik_chat_v2/core/utils/Config_Size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';


// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/services.dart';



/// button used to open/close microphone
class ZegoToggleMicrophoneButton extends StatefulWidget {
  const ZegoToggleMicrophoneButton({
    Key? key,
    this.onPressed,
    this.defaultOn = true,
    required  this.zegoLiveSeatManager,
    this.muteMode = false,
  }) : super(key: key);

  final void Function(bool isON)? onPressed;

  final bool defaultOn;
  final bool muteMode;
  // to get index of seat
  final ZegoLiveSeatManager zegoLiveSeatManager ;

  @override
  State<ZegoToggleMicrophoneButton> createState() =>
      _ZegoToggleMicrophoneButtonState();
}

class _ZegoToggleMicrophoneButtonState
    extends State<ZegoToggleMicrophoneButton> {
  @override
  void initState() {
    super.initState();
 if(!MainScreen.iskeepInRoom.value){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      /// synchronizing the default status
      ZegoUIKit().turnMicrophoneOn(widget.defaultOn, muteMode: widget.muteMode);
    });
 }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable:
          ZegoUIKit().getMicrophoneStateNotifier(ZegoUIKit().getLocalUser().id),
      builder: (context, isMicrophoneOn, _) {
        return   GestureDetector(
            onTap:  onPressed,
            child:
            isMicrophoneOn ?
            Image.asset(AssetsPath.normalMic , width: 40.r, height: 40.r ,)
            : Image.asset(AssetsPath.mute , width: 40.r, height: 40.r ,),
        );
      },
    );
  }

  void onPressed() {
    /// get current microphone state

    if(RoomScreen.listOfMuteSeats.containsKey(widget.zegoLiveSeatManager.getIndexByUserID(ZegoUIKit().getLocalUser().id))||
    RoomScreen.usersHasMute.contains(ZegoUIKit().getLocalUser().id) ){
    }else{
      var valueNotifier =
      ZegoUIKit().getMicrophoneStateNotifier(ZegoUIKit().getLocalUser().id);

      var targetState = !valueNotifier.value;

      if (targetState) {
        requestPermission(Permission.microphone);
      }

      /// reverse current state
      ZegoUIKit().turnMicrophoneOn(targetState);

      if (widget.onPressed != null) {
        widget.onPressed!(targetState);
      }
    }
  }
  // void onPressed() {
  //   /// get current microphone state
  //   final valueNotifier =
  //       ZegoUIKit().getMicrophoneStateNotifier(ZegoUIKit().getLocalUser().id);
  //
  //   final targetState = !valueNotifier.value;
  //
  //   if (targetState) {
  //     requestPermission(Permission.microphone);
  //   }
  //
  //   /// reverse current state
  //   ZegoUIKit().turnMicrophoneOn(targetState, muteMode: widget.muteMode);
  //
  //   if (widget.onPressed != null) {
  //     widget.onPressed!(targetState);
  //   }
  // }
}
