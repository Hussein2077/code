// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// size
Size get zegoLiveButtonSize => Size(72.zR, 72.zR);

Size get zegoLiveButtonIconSize => Size(40.zR, 40.zR);

SizedBox get zegoLiveButtonPadding =>
    SizedBox.fromSize(size: Size.fromRadius(8.zR));

/// @nodoc
enum PopupItemValue {
  takeOnSeat,
  takeOffSeat,
  leaveSeat,
  muteMic,
  unMuteMic,
  showUserDetails,
  lockSeat,
  unLockSeat,
  cancel,
}

class PopupItem {
  final PopupItemValue value;
  final String text;
  final int index;
  final String  userId ;

  const PopupItem(this.value, this.text, { this.index=1 , this.userId = '0' });
}

/// @nodoc
class PrebuiltLiveAudioRoomImage {
  static Image asset(String name) {
    return Image.asset(name);
  }

  static AssetImage assetImage(String name) {
    return AssetImage(name);
  }
}




class PrebuiltLiveAudioRoomIconUrls {
  static const String im =AssetsPath.toolbarMessages;
  static const String toolbarMicNormal = 'assets/images/toolbar_mic_normal.png';
  static const String toolbarMicOff = 'assets/icons/toolbar_mic_off.png';
  static const String toolbarMore = 'assets/icons/toolbar_more.png';


  static const String seatMicrophoneOff = 'assets/icons/seat_mic_off.png';
}
