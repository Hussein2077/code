

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/media.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

/// @nodoc
mixin ZegoMediaService {
  /// Start playing.
  Future<MediaPlayResult> playMedia({
    required String filePathOrURL,
    bool enableRepeat = false,
  }) async {
    return ZegoUIKitCore.shared.playMedia(
      filePathOrURL: filePathOrURL,
      enableRepeat: enableRepeat,
    );
  }

  /// Stop playing.
  Future<void> stopMedia() async {
    return ZegoUIKitCore.shared.stopMedia();
  }

  /// Pause playing.
  Future<void> pauseMedia() async {
    return ZegoUIKitCore.shared.pauseMedia();
  }

  /// Resume playing.
  Future<void> resumeMedia() async {
    return ZegoUIKitCore.shared.resumeMedia();
  }

  /// Set the specified playback progress, Unit is millisecond.
  ///
  /// - [millisecond] Point in time of specified playback progress
  Future<MediaSeekToResult> seekTo(int millisecond) async {
    return ZegoUIKitCore.shared.mediaSeekTo(millisecond);
  }

  /// Set media player volume. Both the local play volume and the publish volume are set.
  ///
  /// - [volume] The range is 0 ~ 100. The default is 30.
  Future<void> setMediaVolume(int volume) async {
    return ZegoUIKitCore.shared.setMediaVolume(volume);
  }

  int getMediaVolume() {
    return ZegoUIKitCore.shared.getMediaVolume();
  }

  ValueNotifier<int> getMediaVolumeNotifier() {
    return ZegoUIKitCore.shared.getMediaVolumeNotifier();
  }

  /// Get the total progress of your media resources, Returns Unit is millisecond.
  int getMediaTotalDuration() {
    return ZegoUIKitCore.shared.getMediaTotalDuration();
  }

  /// Get current playing progress.
  int getMediaCurrentProgress() {
    return ZegoUIKitCore.shared.getMediaCurrentProgress();
  }

  ValueNotifier<int> getMediaCurrentProgressNotifier() {
    return ZegoUIKitCore.shared.getMediaCurrentProgressNotifier();
  }

  MediaType getMediaType() {
    return ZegoUIKitCore.shared.getMediaType();
  }

  ValueNotifier<MediaType> getMediaTypeNotifier() {
    return ZegoUIKitCore.shared.getMediaTypeNotifier();
  }

  ValueNotifier<MediaPlayState> getMediaPlayStateNotifier() {
    return ZegoUIKitCore.shared.getMediaPlayStateNotifier();
  }

  Future<List<PlatformFile>> pickPureAudioMediaFile() async {
    return ZegoUIKitCore.shared.pickPureAudioMediaFile();
  }

  Future<List<PlatformFile>> pickVideoMediaFile() async {
    return ZegoUIKitCore.shared.pickVideoMediaFile();
  }

  Future<List<PlatformFile>> pickMediaFile() async {
    return ZegoUIKitCore.shared.pickMediaFile();
  }

  MediaInfo getMediaInfo() {
    return ZegoUIKitCore.shared.getMediaInfo();
  }
}
