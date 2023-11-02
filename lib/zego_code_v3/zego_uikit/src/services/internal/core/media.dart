
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/audio_video.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';


/// @nodoc
extension ZegoUIKitCoreBaseMedia on ZegoUIKitCore {
  Future<MediaPlayResult> playMedia({
    required String filePathOrURL,
    bool enableRepeat = false,
    bool autoStart = true,
  }) async {
    if (null != coreData.currentMediaPlayer) {
      await stopMedia();
    }

    final playResult = await coreData.playMedia(
      filePathOrURL: filePathOrURL,
      enableRepeat: enableRepeat,
      autoStart: autoStart,
    );

    if (0 == playResult.errorCode) {
      ZegoLoggerService.logInfo(
        'playMedia finished, try start publish stream',
        tag: 'uikit core',
        subTag: 'media',
      );
      await coreData
          .startPublishingStream(streamType: ZegoStreamType.media)
          .then((value) {
        /// sync media type via stream extra info
        final streamExtraInfo = <String, dynamic>{
          streamSEIKeyMediaType: coreData.mediaType.value.index,
        };

        final extraInfo = jsonEncode(streamExtraInfo);
        ZegoExpressEngine.instance.setStreamExtraInfo(
          extraInfo,
          channel: ZegoStreamType.media.channel,
        );
      });
    }

    return playResult;
  }

  Future<void> startMedia() async {
    await coreData.startMedia();
  }

  Future<void> stopMedia() async {
    await coreData.stopMedia();

    await coreData.stopPublishingStream(streamType: ZegoStreamType.media);
  }

  Future<void> pauseMedia() async {
    return coreData.pauseMedia();
  }

  Future<void> resumeMedia() async {
    return coreData.resumeMedia();
  }

  Future<MediaSeekToResult> mediaSeekTo(int millisecond) async {
    return coreData.mediaSeekTo(millisecond);
  }

  Future<void> setMediaVolume(int volume) async {
    return coreData.setMediaVolume(volume);
  }

  int getMediaVolume() {
    return coreData.getMediaVolume();
  }

  Future<void> muteMediaLocal(bool mute) async {
    return coreData.muteMediaLocal(mute);
  }

  int getMediaTotalDuration() {
    return coreData.getMediaTotalDuration();
  }

  int getMediaCurrentProgress() {
    return coreData.mediaProgress.value;
  }

  MediaType getMediaType() {
    return coreData.mediaType.value;
  }

  ValueNotifier<int> getMediaVolumeNotifier() {
    return coreData.mediaVolume;
  }

  ValueNotifier<int> getMediaCurrentProgressNotifier() {
    return coreData.mediaProgress;
  }

  ValueNotifier<MediaType> getMediaTypeNotifier() {
    return coreData.mediaType;
  }

  ValueNotifier<MediaPlayState> getMediaPlayStateNotifier() {
    return coreData.mediaState;
  }

  ValueNotifier<bool> getMediaMuteNotifier() {
    return coreData.mediaMute;
  }

  Future<List<PlatformFile>> pickPureAudioMediaFile() async {
    return coreData.pickMediaFiles(
      allowMultiple: false,
      allowedExtensions: coreData.pureAudioExtensions,
    );
  }

  Future<List<PlatformFile>> pickVideoMediaFile() async {
    return coreData.pickMediaFiles(
      allowMultiple: false,
      allowedExtensions: coreData.videoExtensions,
    );
  }

  Future<List<PlatformFile>> pickMediaFile() async {
    return coreData.pickMediaFiles(
      allowMultiple: false,
    );
  }

  MediaInfo getMediaInfo() {
    return MediaInfo.fromZego(coreData.mediaInfo);
  }
}
