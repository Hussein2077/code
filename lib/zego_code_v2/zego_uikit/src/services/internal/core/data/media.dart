// Dart imports:
import 'dart:async';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/audio_video_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/permission_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:

mixin ZegoUIKitCoreDataMedia {
  ZegoMediaPlayer? currentMediaPlayer;
  int _mediaDuration = 0;

  /// [0~200] => [0~100]
  final mediaVolume = ValueNotifier<int>(30);

  /// millisecond
  final mediaProgress = ValueNotifier<int>(0);
  double mediaSoundLevel = 0.0;
  final mediaState = ValueNotifier<MediaPlayState>(MediaPlayState.NoPlay);
  final mediaType = ValueNotifier<MediaType>(MediaType.Unknown);
  ZegoMediaPlayerMediaInfo? mediaInfo;

  List<String> get pureAudioExtensions => ['mp3', 'aac', 'wav', 'm4a'];

  List<String> get videoExtensions => ['mp4', 'avi', 'mov'];

  ZegoVideoConfig getPreferMediaVideoConfig() {
    if (null == mediaInfo) {
      return ZegoVideoConfig.preset(ZegoVideoConfigPreset.Preset540P);
    }

    var preset = ZegoVideoConfigPreset.Preset540P;
    final mediaHeight = mediaInfo!.height;
    if (mediaHeight <= 180) {
      preset = ZegoVideoConfigPreset.Preset180P;
    } else if (mediaHeight <= 270) {
      preset = ZegoVideoConfigPreset.Preset270P;
    } else if (mediaHeight <= 360) {
      preset = ZegoVideoConfigPreset.Preset360P;
    } else if (mediaHeight <= 540) {
      preset = ZegoVideoConfigPreset.Preset540P;
    } else if (mediaHeight <= 720) {
      preset = ZegoVideoConfigPreset.Preset720P;
    } else {
      preset = ZegoVideoConfigPreset.Preset1080P;
    }
    return ZegoVideoConfig.preset(preset)
      ..captureHeight = mediaInfo!.height
      ..captureWidth = mediaInfo!.width
      ..encodeHeight = mediaInfo!.height
      ..encodeWidth = mediaInfo!.width
      ..fps = mediaInfo!.frameRate;
  }

  Future<void> clearMedia() async {
    stopMedia();

    if (null != currentMediaPlayer) {
      await ZegoExpressEngine.instance.destroyMediaPlayer(currentMediaPlayer!);
      currentMediaPlayer = null;
    }
  }

  Future<MediaPlayResult> playMedia({
    required String filePathOrURL,
    bool enableRepeat = false,
  }) async {
    if (MediaPlayState.Playing == mediaState.value ||
        MediaPlayState.Pausing == mediaState.value) {
      ZegoLoggerService.logInfo(
        'playMedia exist playing source:${mediaState.value}',
        tag: 'uikit',
        subTag: 'core data media',
      );
      await stopMedia();
    }

    currentMediaPlayer ??= await ZegoExpressEngine.instance.createMediaPlayer();
    currentMediaPlayer!.enableSoundLevelMonitor(true, 200);
    currentMediaPlayer!.enableRepeat(enableRepeat);

    ZegoLoggerService.logInfo(
      'try load resource:$filePathOrURL',
      tag: 'uikit',
      subTag: 'core data media',
    );
    final loadResult = await currentMediaPlayer!.loadResource(filePathOrURL);
    if (0 != loadResult.errorCode) {
      ZegoLoggerService.logInfo(
        'loadResource, code:${loadResult.errorCode}',
        tag: 'uikit',
        subTag: 'core data media',
      );
      return MediaPlayResult(errorCode: loadResult.errorCode);
    }

    mediaInfo = await currentMediaPlayer!.getMediaInfo();

    mediaState.value = MediaPlayState.Playing;

    final pathExtension = path.extension(filePathOrURL);

    var extension = 'mp3';
    if(pathExtension.length>1){
      extension = pathExtension.substring(1);
    }
   //  remove point
    if (pureAudioExtensions.contains(extension)) {
      mediaType.value = MediaType.PureAudio;
    } else if (videoExtensions.contains(extension)) {
      mediaType.value = MediaType.Video;
    } else {
      ZegoLoggerService.logInfo(
        'parse media extension error, path:$filePathOrURL, extension:$extension',
        tag: 'uikit',
        subTag: 'core data media',
      );
      mediaType.value = MediaType.Unknown;
    }

    ZegoLoggerService.logInfo(
      'try start media..',
      tag: 'uikit',
      subTag: 'core data media',
    );
    await currentMediaPlayer!.start();
    ZegoLoggerService.logInfo(
      'start done',
      tag: 'uikit',
      subTag: 'core data media',
    );

    mediaVolume.value = await currentMediaPlayer!.getPlayVolume() ~/ 2;
    _mediaDuration = await currentMediaPlayer!.getTotalDuration();
    mediaProgress.value = await currentMediaPlayer!.getCurrentProgress();

    return MediaPlayResult(errorCode: 0);
  }

  Future<void> stopMedia() async {
    if (null == currentMediaPlayer) {
      return;
    }

    ZegoLoggerService.logInfo(
      'stopMedia',
      tag: 'uikit',
      subTag: 'core data media',
    );
    currentMediaPlayer!.stop();

    _mediaDuration = 0;
    mediaVolume.value = 30;
    mediaProgress.value = 0;
    mediaSoundLevel = 0.0;
    mediaState.value = MediaPlayState.NoPlay;
    mediaType.value = MediaType.Unknown;

    ZegoLoggerService.logInfo(
      'stopMedia done',
      tag: 'uikit',
      subTag: 'core data media',
    );
  }

  Future<void> pauseMedia() async {
    if (MediaPlayState.Pausing == mediaState.value) {
      ZegoLoggerService.logInfo(
        'pauseMedia, state(${mediaState.value}) is not pausing',
        tag: 'uikit',
        subTag: 'core data media',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'pauseMedia',
      tag: 'uikit',
      subTag: 'core data media',
    );
    mediaState.value = MediaPlayState.Pausing;
    return currentMediaPlayer?.pause();
  }

  Future<void> resumeMedia() async {
    if (MediaPlayState.Playing == mediaState.value) {
      ZegoLoggerService.logInfo(
        'resumeMedia, state(${mediaState.value}) is playing',
        tag: 'uikit',
        subTag: 'core data media',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'resumeMedia',
      tag: 'uikit',
      subTag: 'core data media',
    );
    mediaState.value = MediaPlayState.Playing;
    return currentMediaPlayer?.resume();
  }

  Future<MediaSeekToResult> mediaSeekTo(int millisecond) async {
    ZegoLoggerService.logInfo(
      'media seek to $millisecond',
      tag: 'uikit',
      subTag: 'core data media',
    );

    /// change local first, sdk callback will correct if failed
    mediaProgress.value = millisecond;

    final result = await currentMediaPlayer?.seekTo(millisecond);
    ZegoLoggerService.logInfo(
      'media seek result:${result?.errorCode}',
      tag: 'uikit',
      subTag: 'core data media',
    );

    return MediaSeekToResult(errorCode: result?.errorCode ?? 0);
  }

  Future<void> setMediaVolume(int volume) async {
    if (volume == mediaVolume.value) {
      return;
    }

    ZegoLoggerService.logInfo(
      'set media volume:$volume',
      tag: 'uikit',
      subTag: 'core data media',
    );
    mediaVolume.value = volume;
    return currentMediaPlayer?.setVolume(volume);
  }

  int getMediaVolume() {
    return mediaVolume.value;
  }

  int getMediaTotalDuration() {
    return _mediaDuration;
  }

  Future<void> _syncMediaInfoBySEI() async {
    return ZegoUIKitCore.shared.coreData.sendSEI(
      ZegoUIKitInnerSEIType.mediaSyncInfo.name,
      {
        streamSEIKeyMediaStatus: mediaState.value.index,
        streamSEIKeyMediaProgress: mediaProgress.value,
        streamSEIKeyMediaDuration: _mediaDuration,
        streamSEIKeyMediaType: mediaType.value.index,
        streamSEIKeyMediaSoundLevel: mediaSoundLevel,
      },
      ZegoStreamType.media.channel,
    );
  }

  void uninitMediaEventHandle() {
    ZegoLoggerService.logInfo(
      'uninitMediaEventHandle',
      tag: 'uikit',
      subTag: 'core data media',
    );

    ZegoExpressEngine.onMediaPlayerStateUpdate = null;
    ZegoExpressEngine.onMediaPlayerNetworkEvent = null;
    ZegoExpressEngine.onMediaPlayerPlayingProgress = null;
    ZegoExpressEngine.onMediaPlayerRecvSEI = null;
    ZegoExpressEngine.onMediaPlayerSoundLevelUpdate = null;
    ZegoExpressEngine.onMediaPlayerFrequencySpectrumUpdate = null;
    ZegoExpressEngine.onMediaPlayerFirstFrameEvent = null;
  }

  void initMediaEventHandle() {
    ZegoLoggerService.logInfo(
      'initMediaEventHandle',
      tag: 'uikit',
      subTag: 'core data media',
    );

    ZegoExpressEngine.onMediaPlayerStateUpdate = onMediaPlayerStateUpdate;
    ZegoExpressEngine.onMediaPlayerNetworkEvent = onMediaPlayerNetworkEvent;
    ZegoExpressEngine.onMediaPlayerPlayingProgress =
        onMediaPlayerPlayingProgress;
    ZegoExpressEngine.onMediaPlayerRecvSEI = onMediaPlayerRecvSEI;
    ZegoExpressEngine.onMediaPlayerSoundLevelUpdate =
        onMediaPlayerSoundLevelUpdate;
    ZegoExpressEngine.onMediaPlayerFrequencySpectrumUpdate =
        onMediaPlayerFrequencySpectrumUpdate;
    ZegoExpressEngine.onMediaPlayerFirstFrameEvent =
        onMediaPlayerFirstFrameEvent;
  }

  void onMediaPlayerStateUpdate(
    ZegoMediaPlayer mediaPlayer,
    ZegoMediaPlayerState state,
    int errorCode,
  ) {
    ZegoLoggerService.logInfo(
      'onMediaPlayerStateUpdate state:$state, errorCode:$errorCode',
      tag: 'uikit',
      subTag: 'core data media',
    );

    mediaState.value = MediaPlayState.values[state.index];

    _syncMediaInfoBySEI();
  }

  void onMediaPlayerNetworkEvent(
    ZegoMediaPlayer mediaPlayer,
    ZegoMediaPlayerNetworkEvent networkEvent,
  ) {
    ZegoLoggerService.logInfo(
      'onMediaPlayerNetworkEvent $networkEvent',
      tag: 'uikit',
      subTag: 'core data media',
    );
  }

  void onMediaPlayerPlayingProgress(
    ZegoMediaPlayer mediaPlayer,
    int millisecond,
  ) {
    mediaProgress.value = millisecond;
    _syncMediaInfoBySEI();
  }

  void onMediaPlayerRecvSEI(
    ZegoMediaPlayer mediaPlayer,
    Uint8List data,
  ) {
    // ZegoLoggerService.logInfo(
    //   'onMediaPlayerRecvSEI $data',
    //   tag: 'uikit',
    //   subTag: 'core data media',
    // );
  }

  void onMediaPlayerRecvSEIFromSDK(
    String streamID,
    String userID,
    Map<String, dynamic> sei,
  ) {
    final mediaOwnerID =
        ZegoUIKitCore.shared.coreData.streamDic[streamID] ?? '';
    final isLocalMedia =
        mediaOwnerID == ZegoUIKitCore.shared.coreData.localUser.id;

    if (sei.keys.contains(streamSEIKeyMediaStatus)) {
      final playStat =
          MediaPlayState.values[sei[streamSEIKeyMediaStatus] as int];
      if (isLocalMedia) {
        /// remote user control local media
        switch (playStat) {
          case MediaPlayState.NoPlay:
            break;
          case MediaPlayState.Playing:
            resumeMedia();
            break;
          case MediaPlayState.Pausing:
            pauseMedia();
            break;
          case MediaPlayState.PlayEnded:
            stopMedia();
            break;
        }
      } else {
        mediaState.value = playStat;
      }
    }

    if (sei.keys.contains(streamSEIKeyMediaProgress)) {
      final progress = sei[streamSEIKeyMediaProgress] as int? ?? 0;
      if (isLocalMedia) {
        /// remote user control local media
        mediaSeekTo(progress);
      } else {
        mediaProgress.value = progress;
      }
    }

    if (sei.keys.contains(streamSEIKeyMediaDuration)) {
      final duration = sei[streamSEIKeyMediaDuration] as int? ?? 0;
      if (!isLocalMedia) {
        _mediaDuration = duration;
      }
    }

    if (sei.keys.contains(streamSEIKeyMediaType)) {
      final type = MediaType.values[sei[streamSEIKeyMediaType] as int];
      if (!isLocalMedia) {
        mediaType.value = type;
      }
    }

    if (sei.keys.contains(streamSEIKeyMediaSoundLevel)) {
      final soundLevel = sei[streamSEIKeyMediaSoundLevel] as double? ?? 0.0;
      if (!isLocalMedia) {
        final targetUserIndex = ZegoUIKitCore.shared.coreData.remoteUsersList
            .indexWhere((user) => mediaOwnerID == user.id);
        if (-1 != targetUserIndex) {
          final targetUser =
              ZegoUIKitCore.shared.coreData.remoteUsersList[targetUserIndex];
          targetUser.auxChannel.soundLevel.add(soundLevel);
        }
      }
    }
  }

  void onMediaPlayerSoundLevelUpdate(
    ZegoMediaPlayer mediaPlayer,
    double soundLevel,
  ) {
    mediaSoundLevel = soundLevel;

    ZegoUIKitCore.shared.coreData.localUser.auxChannel.soundLevel
        .add(soundLevel);
  }

  void onMediaPlayerFrequencySpectrumUpdate(
    ZegoMediaPlayer mediaPlayer,
    List<double> spectrumList,
  ) {
    ZegoLoggerService.logInfo(
      'onMediaPlayerFrequencySpectrumUpdate $spectrumList',
      tag: 'uikit',
      subTag: 'core data media',
    );
  }

  void onMediaPlayerFirstFrameEvent(
    ZegoMediaPlayer mediaPlayer,
    ZegoMediaPlayerFirstFrameEvent event,
  ) {
    ZegoLoggerService.logInfo(
      'onMediaPlayerFirstFrameEvent $event',
      tag: 'uikit',
      subTag: 'core data media',
    );
  }

  Future<List<PlatformFile>> pickMediaFiles({
    bool allowMultiple = true,
    List<String>? allowedExtensions,
  }) async {
    try {
      await requestPermission(Permission.storage);
      final ret = (await FilePicker.platform.pickFiles(
            type: null == allowedExtensions ? FileType.media : FileType.custom,
            allowMultiple: allowMultiple,
            allowedExtensions: allowedExtensions,
            onFileLoading: (p0) {
              debugPrint('');
              ZegoLoggerService.logInfo(
                'pick files onFileLoading:$p0,${DateTime.now().millisecondsSinceEpoch}',
                tag: 'uikit',
                subTag: 'core data media',
              );
            },
          ))
              ?.files ??
          [];
      ZegoLoggerService.logInfo(
        'pick files: $ret, ${DateTime.now().millisecondsSinceEpoch}',
        tag: 'uikit',
        subTag: 'core data media',
      );
      return ret;
    } on PlatformException catch (e) {
      ZegoLoggerService.logInfo(
        'pick files Unsupported operation $e',
        tag: 'uikit',
        subTag: 'core data media',
      );
    } catch (e) {
      ZegoLoggerService.logInfo(
        'pick files exception:$e',
        tag: 'uikit',
        subTag: 'core data media',
      );
    }

    return [];
  }
}
