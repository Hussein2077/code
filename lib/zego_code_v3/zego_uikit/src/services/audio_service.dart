

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/audio.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

/// @nodoc
mixin ZegoAudioService {
  /// start play all audio video
  Future<void> startPlayAllAudioVideo() async {
    return ZegoUIKitCore.shared.startPlayAllAudioVideo();
  }

  /// stop play all audio video
  Future<void> stopPlayAllAudioVideo() async {
    return ZegoUIKitCore.shared.stopPlayAllAudioVideo();
  }


  Future<void> muteUserAudio(String userID, bool mute) async {
    return ZegoUIKitCore.shared.muteUserAudio(userID, mute);
  }


  /// set audio output to speaker
  void setAudioOutputToSpeaker(bool isSpeaker) {
    ZegoUIKitCore.shared.setAudioOutputToSpeaker(isSpeaker);
  }





  /// turn on/off microphone
  void turnMicrophoneOn(bool isOn, {String? userID, bool muteMode = false}) {
    ZegoUIKitCore.shared.turnMicrophoneOn(
      userID?.isEmpty ?? true
          ? ZegoUIKitCore.shared.coreData.localUser.id
          : userID!,
      isOn,
      muteMode: muteMode,
    );
  }





  void setAudioVideoResourceMode(ZegoAudioVideoResourceMode mode) {
    ZegoUIKitCore.shared.setAudioVideoResourceMode(mode);
  }

  /// get audio video view notifier
  ValueNotifier<Widget?> getAudioVideoViewNotifier(
    String? userID, {
    ZegoStreamType streamType = ZegoStreamType.main,
  }) {
    if (userID == null ||
        userID == ZegoUIKitCore.shared.coreData.localUser.id) {
      switch (streamType) {
        case ZegoStreamType.main:
          return ZegoUIKitCore.shared.coreData.localUser.mainChannel.view;
        case ZegoStreamType.media:
        case ZegoStreamType.screenSharing:
        case ZegoStreamType.mix:
          return ZegoUIKitCore.shared.coreData.localUser.auxChannel.view;
      }
    } else {
      final targetUser = ZegoUIKitCore.shared.coreData.remoteUsersList
          .firstWhere((user) => user.id == userID,
              orElse: ZegoUIKitCoreUser.empty);
      switch (streamType) {
        case ZegoStreamType.main:
          return targetUser.mainChannel.view;
        case ZegoStreamType.media:
        case ZegoStreamType.screenSharing:
        case ZegoStreamType.mix:
          return targetUser.auxChannel.view;
        // return targetUser.thirdChannel.view;
      }
    }
  }





  /// get microphone state notifier
  ValueNotifier<bool> getMicrophoneStateNotifier(String userID) {
    return ZegoUIKitCore.shared.coreData.getUser(userID).microphone;
  }

  /// get audio output device notifier
  ValueNotifier<ZegoAudioRoute> getAudioOutputDeviceNotifier(String userID) {
    return ZegoUIKitCore.shared.coreData.getUser(userID).audioRoute;
  }

  /// get screen share notifier
  ValueNotifier<bool> getScreenSharingStateNotifier() {
    return ZegoUIKitCore.shared.coreData.isScreenSharing;
  }

  /// get sound level notifier
  Stream<double> getSoundLevelStream(String userID) {
    return ZegoUIKitCore.shared.coreData
        .getUser(userID)
        .mainChannel
        .soundLevel
        .stream;
  }

  Stream<List<ZegoUIKitUser>> getAudioVideoListStream() {
    return ZegoUIKitCore.shared.coreData.audioVideoListStreamCtrl.stream
        .map((users) => users.map((e) => e.toZegoUikitUser()).toList());
  }

  /// get audio video list
  List<ZegoUIKitUser> getAudioVideoList() {
    return ZegoUIKitCore.shared.coreData
        .getAudioVideoList()
        .map((e) => e.toZegoUikitUser())
        .toList();
  }

  Stream<List<ZegoUIKitUser>> getScreenSharingListStream() {
    return ZegoUIKitCore.shared.coreData.screenSharingListStreamCtrl.stream
        .map((users) => users.map((e) => e.toZegoUikitUser()).toList());
  }

  /// get screen sharing list
  List<ZegoUIKitUser> getScreenSharingList() {
    return ZegoUIKitCore.shared.coreData
        .getAudioVideoList(streamType: ZegoStreamType.screenSharing)
        .map((e) => e.toZegoUikitUser())
        .toList();
  }

  Stream<List<ZegoUIKitUser>> getMediaListStream() {
    return ZegoUIKitCore.shared.coreData.mediaListStreamCtrl.stream
        .map((users) => users.map((e) => e.toZegoUikitUser()).toList());
  }

  /// get media list
  List<ZegoUIKitUser> getMediaList() {
    return ZegoUIKitCore.shared.coreData
        .getAudioVideoList(streamType: ZegoStreamType.media)
        .map((e) => e.toZegoUikitUser())
        .toList();
  }

  /// start share screen
  Future<void> startSharingScreen() async {
    return ZegoUIKitCore.shared.coreData.startSharingScreen();
  }

  /// stop share screen
  Future<void> stopSharingScreen() async {
    return ZegoUIKitCore.shared.coreData.stopSharingScreen();
  }



  /// update texture render orientation
  void updateTextureRendererOrientation(Orientation orientation) {
    ZegoUIKitCore.shared.updateTextureRendererOrientation(orientation);
  }

  /// update app orientation
  void updateAppOrientation(DeviceOrientation orientation) {
    ZegoUIKitCore.shared.updateAppOrientation(orientation);
  }



  Future<void> startPlayAnotherRoomAudioVideo(String roomID, String userID,
      {String userName = ''}) async {
    return ZegoUIKitCore.shared
        .startPlayAnotherRoomAudioVideo(roomID, userID, userName);
  }

  Future<void> stopPlayAnotherRoomAudioVideo(String userID) async {
    return ZegoUIKitCore.shared.stopPlayAnotherRoomAudioVideo(userID);
  }

  Future<ZegoMixerStartResult> startMixerTask(ZegoMixerTask task) async {
    return ZegoUIKitCore.shared.startMixerTask(task);
  }

  Future<ZegoMixerStopResult> stopMixerTask(ZegoMixerTask task) async {
    return ZegoUIKitCore.shared.stopMixerTask(task);
  }

  Future<void> startPlayMixAudioVideo(
      String mixerID, List<String> users) async {
    return ZegoUIKitCore.shared.startPlayMixAudioVideo(mixerID, users);
  }

  Future<void> stopPlayMixAudioVideo(String mixerID) async {
    return ZegoUIKitCore.shared.stopPlayMixAudioVideo(mixerID);
  }

  ValueNotifier<Widget?> getMixAudioVideoViewNotifier(String mixerID) {
    return ZegoUIKitCore.shared.coreData.mixerStreamDic[mixerID]?.view ??
        ValueNotifier(null);
  }



  ValueNotifier<bool> getMixAudioVideoMicrophoneStateNotifier(
      String mixerID, String userID) {
    return ZegoUIKitCore.shared.coreData.mixerStreamDic[mixerID]?.users
            .firstWhere((user) => user.id == userID,
                orElse: ZegoUIKitCoreUser.empty)
            .microphone ??
        ValueNotifier(false);
  }

  ValueNotifier<bool> getMixAudioVideoLoadedNotifier(String mixerID) {
    return ZegoUIKitCore.shared.coreData.mixerStreamDic[mixerID]?.loaded ??
        ValueNotifier(false);
  }

  Stream<ZegoUIKitReceiveSEIEvent> getReceiveSEIStream() {
    return ZegoUIKitCore.shared.coreData.receiveSEIStreamCtrl.stream;
  }
}
