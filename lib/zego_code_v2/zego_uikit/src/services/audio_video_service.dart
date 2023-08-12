import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/data/screen_sharing.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/defines.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/audio_video_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';

import '../../zego_uikit.dart';
/// @nodoc

/// @nodoc
mixin ZegoAudioVideoService {
  /// start play all audio video
  void startPlayAllAudioVideo() {
    ZegoUIKitCore.shared.startPlayAllAudioVideo();
  }

  /// stop play all audio video
  void stopPlayAllAudioVideo() {
    ZegoUIKitCore.shared.stopPlayAllAudioVideo();
  }

  void muteUserAudioVideo(String userID, bool mute) {
    ZegoUIKitCore.shared.muteUserAudioVideo(userID, mute);
  }

  /// set audio output to speaker
  void setAudioOutputToSpeaker(bool isSpeaker) {
    ZegoUIKitCore.shared.setAudioOutputToSpeaker(isSpeaker);
  }

  /// update video config
  void setVideoConfig(
      ZegoVideoConfig config,
      ZegoStreamType streamType,
      ) {
    ZegoUIKitCore.shared.setVideoConfig(config, streamType);
  }

  /// turn on/off camera
  // void turnCameraOn(bool isOn, {String? userID}) {
  //   ZegoUIKitCore.shared.turnCameraOn(
  //       userID?.isEmpty ?? true
  //           ? ZegoUIKitCore.shared.coreData.localUser.id
  //           : userID!,
  //       isOn);
  // }

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

  /// local use front facing camera
  void useFrontFacingCamera(bool isFrontFacing) {
    ZegoUIKitCore.shared.useFrontFacingCamera(isFrontFacing);
  }

  /// set video mirror mode
  void enableVideoMirroring(bool isVideoMirror) {
    ZegoUIKitCore.shared.enableVideoMirroring(isVideoMirror);
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

  /// get camera state notifier
  ValueNotifier<bool> getCameraStateNotifier(String userID) {
    return ZegoUIKitCore.shared.coreData.getUser(userID).camera;
  }

  /// get front facing camera switch notifier
  ValueNotifier<bool> getUseFrontFacingCameraStateNotifier(String userID) {
    return ZegoUIKitCore.shared.coreData.getUser(userID).isFrontFacing;
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

  /// get video size notifier
  ValueNotifier<Size> getVideoSizeNotifier(String userID) {
    return ZegoUIKitCore.shared.coreData.getUser(userID).mainChannel.viewSize;
  }

  /// update texture render orientation
  void updateTextureRendererOrientation(Orientation orientation) {
    ZegoUIKitCore.shared.updateTextureRendererOrientation(orientation);
  }

  /// update app orientation
  void updateAppOrientation(DeviceOrientation orientation) {
    ZegoUIKitCore.shared.updateAppOrientation(orientation);
  }

  /// update video view mode
  void updateVideoViewMode(bool useVideoViewAspectFill) {
    ZegoUIKitCore.shared.updateVideoViewMode(useVideoViewAspectFill);
  }

  Future<void> startPlayAnotherRoomAudioVideo(String roomID, String userID,
      {String userName = ''}) async {
    return ZegoUIKitCore.shared
        .startPlayAnotherRoomAudioVideo(roomID, userID, userName);
  }

  Future<void> stopPlayAnotherRoomAudioVideo(String userID) async {
    return ZegoUIKitCore.shared.stopPlayAnotherRoomAudioVideo(userID);
  }

  Future<void> muteAudio(String userID, bool mute) async {
    return ZegoUIKitCore.shared.muteAudio(userID, mute);
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

  ValueNotifier<bool> getMixAudioVideoCameraStateNotifier(
      String mixerID, String userID) {
    return ZegoUIKitCore.shared.coreData.mixerStreamDic[mixerID]?.users
        .firstWhere((user) => user.id == userID,
        orElse: ZegoUIKitCoreUser.empty)
        .camera ??
        ValueNotifier(false);
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
