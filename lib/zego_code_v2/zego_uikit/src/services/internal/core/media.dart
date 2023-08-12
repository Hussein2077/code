

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/audio_video_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

/// @nodoc

extension ZegoUIKitCoreBaseMedia on ZegoUIKitCore {
  Future<MediaPlayResult> playMedia({
    required String filePathOrURL,
    bool enableRepeat = false,
  }) async {
    if (null != coreData.currentMediaPlayer) {
      stopMedia();
    }

    final playResult = await coreData.playMedia(
      filePathOrURL: filePathOrURL,
      enableRepeat: enableRepeat,
    );

    if (0 == playResult.errorCode) {
      ZegoLoggerService.logInfo(
        'playMedia finished, try start publish stream',
        tag: 'uikit',
        subTag: 'core',
      );
      await coreData.startPublishingStream(streamType: ZegoStreamType.media);
    }

    return playResult;
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
