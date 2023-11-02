// Dart imports:
import 'dart:core';

// Project imports:
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_controller.dart';

// Project imports:

/// @nodoc
class ZegoUIKitPrebuiltLiveAudioRoomData {
  const ZegoUIKitPrebuiltLiveAudioRoomData({
    required this.appID,
    required this.appSign,
    required this.roomID,
    required this.userID,
    required this.userName,
    required this.config,
    required this.roomData,
    required this.isPrebuiltFromMinimizing,
    this.controller,
  });

  /// you need to fill in the appID you obtained from console.zegocloud.com
  final int appID;

  final EnterRoomModel roomData ;
  /// for Android/iOS
  /// you need to fill in the appID you obtained from console.zegocloud.com
  final String appSign;

  /// local user info
  final String userID;
  final String userName;

  /// You can customize the liveName arbitrarily,
  /// just need to know: users who use the same liveName can talk with each other.
  final String roomID;

  final ZegoLiveAudioRoomController? controller;

  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;

  final bool isPrebuiltFromMinimizing;

  @override
  String toString() {
    return 'app id:$appID, app sign:$appSign, room id:$roomID, '
        'isPrebuiltFromMinimizing: $isPrebuiltFromMinimizing, '
        'user id:$userID, user name:$userName, '
        'config:${config.toString()}';
  }
}
