



import 'package:flutter/widgets.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';

/// @nodoc
mixin ZegoLiveAudioRoomControllerPrivate {
  ZegoUIKitPrebuiltLiveAudioRoomConfig? prebuiltConfig;
  ZegoLiveConnectManager? connectManager;
  ZegoLiveSeatManager? seatManager;

  final _hiddenUsersOfMemberListNotifier = ValueNotifier<List<String>>([]);

  ValueNotifier<List<String>> get hiddenUsersOfMemberListNotifier =>
      _hiddenUsersOfMemberListNotifier;

  /// DO NOT CALL
  /// Call Inside By Prebuilt
  /// prebuilt assign value to internal variables
  void initByPrebuilt({
    required ZegoUIKitPrebuiltLiveAudioRoomConfig config,
    required ZegoLiveConnectManager? connectManager,
    required ZegoLiveSeatManager? seatManager,
  }) {
    prebuiltConfig = config;
    connectManager = connectManager;
    seatManager = seatManager;
  }

  /// DO NOT CALL
  /// Call Inside By Prebuilt
  /// prebuilt assign value to internal variables
  void uninitByPrebuilt() {
    connectManager = null;
    seatManager = null;
  }
}
