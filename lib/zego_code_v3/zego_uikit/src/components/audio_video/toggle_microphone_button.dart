// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/screen_util.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
/// button used to open/close microphone
class ZegoToggleMicrophoneButton extends StatefulWidget {
  const ZegoToggleMicrophoneButton({
    Key? key,
    this.normalIcon,
    this.offIcon,
    this.onPressed,
    this.defaultOn = true,
    this.iconSize,
    this.buttonSize,
    this.muteMode = false,
    required this.roomData,
    required  this.zegoLiveSeatManager,
  }) : super(key: key);

  final ButtonIcon? normalIcon;
  final ButtonIcon? offIcon;
  final EnterRoomModel roomData ;
  ///  You can do what you want after pressed.
  final void Function(bool isON)? onPressed;

  /// whether to open microphone by default
  final bool defaultOn;

  /// the size of button's icon
  final Size? iconSize;

  /// the size of button
  final Size? buttonSize;

  /// only use mute, will not stop the stream
  final bool muteMode;
  final ZegoLiveSeatManager zegoLiveSeatManager;

  @override
  State<ZegoToggleMicrophoneButton> createState() =>
      _ZegoToggleMicrophoneButtonState();
}

/// @nodoc
class _ZegoToggleMicrophoneButtonState
    extends State<ZegoToggleMicrophoneButton> {
  @override
  void initState() {
    super.initState();
  //todo add contadtion here to handle minimize room
    if(!MainScreen.iskeepInRoom.value){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        /// synchronizing the default status
        ZegoUIKit().turnMicrophoneOn(widget.defaultOn, muteMode: widget.muteMode);
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    /// listen local microphone state changes
    return ValueListenableBuilder<bool>(
      valueListenable:
          ZegoUIKit().getMicrophoneStateNotifier(ZegoUIKit().getLocalUser().id),
      builder: (context, isMicrophoneOn, _) {
        /// update if microphone state changed
        return GestureDetector(
            onTap:  onPressed,
            child:
            isMicrophoneOn ?
            Image.asset(AssetsPath.normalMic , width: 40.zR, height: 40.zR ,)
            : Image.asset(AssetsPath.mute , width: 40.zR, height: 40.zR ,),);
      },
    );
  }

  void onPressed() {
    /// get current microphone state
   if(widget.roomData.ownerId == MyDataModel.getInstance().id){
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
   else if(RoomScreen.listOfMuteSeats.containsKey(widget.zegoLiveSeatManager.getIndexByUserID(ZegoUIKit().getLocalUser().id))||
        RoomScreen.usersHasMute.contains(ZegoUIKit().getLocalUser().id)  ){
      // to handle mute seat
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


}
