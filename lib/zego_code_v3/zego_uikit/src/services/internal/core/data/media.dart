// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/internal.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

mixin ZegoUIKitCoreDataMedia {
  StreamController<List<ZegoUIKitCoreUser>> mediaListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();

  String? mediaOwnerID;
  ZegoMediaPlayer? currentMediaPlayer;
  int _mediaDuration = 0;

  /// [0~200] => [0~100]
  final mediaVolume = ValueNotifier<int>(30);

  /// millisecond
  final mediaProgress = ValueNotifier<int>(0);
  double mediaSoundLevel = 0.0;
  final mediaState = ValueNotifier<MediaPlayState>(MediaPlayState.NoPlay);
  final mediaType = ValueNotifier<MediaType>(MediaType.Unknown);
  final mediaMute = ValueNotifier<bool>(false);

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
    bool autoStart = true,
  }) async {
    ZegoLoggerService.logInfo(
      'play media, path:$filePathOrURL, repeat:$enableRepeat, auto start:$autoStart',
      tag: 'uikit core data',
      subTag: 'media',
    );

    if (MediaPlayState.Playing == mediaState.value ||
        MediaPlayState.Pausing == mediaState.value) {
      ZegoLoggerService.logInfo(
        'playMedia exist playing source:${mediaState.value}',
        tag: 'uikit core data',
        subTag: 'media',
      );
      await stopMedia();
    }

    currentMediaPlayer ??= await ZegoExpressEngine.instance.createMediaPlayer();
    currentMediaPlayer!.enableSoundLevelMonitor(true, 200);
    currentMediaPlayer!.enableRepeat(enableRepeat);

    mediaOwnerID = ZegoUIKitCore.shared.coreData.localUser.id;

    ZegoLoggerService.logInfo(
      'try load resource:$filePathOrURL',
      tag: 'uikit core data',
      subTag: 'media',
    );
    final loadResult = await currentMediaPlayer!.loadResource(filePathOrURL);
    if (0 != loadResult.errorCode) {
      ZegoLoggerService.logInfo(
        'loadResource, code:${loadResult.errorCode}',
        tag: 'uikit core data',
        subTag: 'media',
      );
      return MediaPlayResult(errorCode: loadResult.errorCode);
    }
    mediaState.value = MediaPlayState.LoadReady;

    mediaInfo = await currentMediaPlayer!.getMediaInfo();
    final pathExtension = path.extension(filePathOrURL);
    final extension = pathExtension.substring(1); //  remove point
    if (pureAudioExtensions.contains(extension)) {
      mediaType.value = MediaType.PureAudio;
    } else if (videoExtensions.contains(extension)) {
      mediaType.value = MediaType.Video;
    } else {
      ZegoLoggerService.logInfo(
        'parse media extension error, path:$filePathOrURL, extension:$extension',
        tag: 'uikit core data',
        subTag: 'media',
      );
      mediaType.value = MediaType.Unknown;
    }

    if (autoStart) {
      startMedia();
    }

    currentMediaPlayer!.setPublishVolume(200);

    mediaVolume.value = await currentMediaPlayer!.getPlayVolume() ~/ 2;
    _mediaDuration = await currentMediaPlayer!.getTotalDuration();
    mediaProgress.value = await currentMediaPlayer!.getCurrentProgress();

    return MediaPlayResult(errorCode: 0);
  }

  Future<void> startMedia() async {
    ZegoLoggerService.logInfo(
      'try start media..',
      tag: 'uikit core data',
      subTag: 'media',
    );

    await currentMediaPlayer?.start();
    mediaState.value = MediaPlayState.Playing;

    ZegoLoggerService.logInfo(
      'start done',
      tag: 'uikit core data',
      subTag: 'media',
    );
  }

  Future<void> stopMedia() async {
    ZegoLoggerService.logInfo(
      'stopMedia',
      tag: 'uikit core data',
      subTag: 'media',
    );
    currentMediaPlayer?.stop();

    _mediaDuration = 0;
    mediaVolume.value = 30;
    mediaProgress.value = 0;
    mediaSoundLevel = 0.0;
    mediaState.value = MediaPlayState.NoPlay;
    mediaType.value = MediaType.Unknown;
    mediaMute.value = false;
    mediaOwnerID = null;

    ZegoLoggerService.logInfo(
      'stopMedia done',
      tag: 'uikit core data',
      subTag: 'media',
    );
  }

  Future<void> pauseMedia() async {
    if (MediaPlayState.Pausing == mediaState.value) {
      ZegoLoggerService.logInfo(
        'pauseMedia, state(${mediaState.value}) is not pausing',
        tag: 'uikit core data',
        subTag: 'media',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'pauseMedia',
      tag: 'uikit core data',
      subTag: 'media',
    );
    mediaState.value = MediaPlayState.Pausing;
    return currentMediaPlayer?.pause();
  }

  Future<void> resumeMedia() async {
    if (MediaPlayState.Playing == mediaState.value) {
      ZegoLoggerService.logInfo(
        'resumeMedia, state(${mediaState.value}) is playing',
        tag: 'uikit core data',
        subTag: 'media',
      );
      return;
    }

    ZegoLoggerService.logInfo(
      'resumeMedia',
      tag: 'uikit core data',
      subTag: 'media',
    );
    mediaState.value = MediaPlayState.Playing;
    return currentMediaPlayer?.resume();
  }

  Future<MediaSeekToResult> mediaSeekTo(int millisecond) async {
    ZegoLoggerService.logInfo(
      'media seek to $millisecond',
      tag: 'uikit core data',
      subTag: 'media',
    );

    /// change local first, sdk callback will correct if failed
    mediaProgress.value = millisecond;

    final result = await currentMediaPlayer?.seekTo(millisecond);
    ZegoLoggerService.logInfo(
      'media seek result:${result?.errorCode}',
      tag: 'uikit core data',
      subTag: 'media',
    );

    return MediaSeekToResult(errorCode: result?.errorCode ?? 0);
  }

  Future<void> setMediaVolume(int volume) async {
    if (volume == mediaVolume.value) {
      return;
    }

    ZegoLoggerService.logInfo(
      'set media volume:$volume',
      tag: 'uikit core data',
      subTag: 'media',
    );
    mediaVolume.value = volume;
    return currentMediaPlayer?.setPlayVolume(volume);
  }

  int getMediaVolume() {
    return mediaVolume.value;
  }

  Future<void> muteMediaLocal(bool mute) async {
    mediaMute.value = mute;

    if (null != currentMediaPlayer) {
      ZegoLoggerService.logInfo(
        'mute local, mute:$mute',
        tag: 'uikit core data',
        subTag: 'media',
      );

      currentMediaPlayer?.muteLocal(mute);
    } else {
      // mute remote play stream
      final mediaOwner =
          ZegoUIKitCore.shared.coreData.getUser(mediaOwnerID ?? '');
      ZegoLoggerService.logInfo(
        'mute remote, mute:$mute, owner:$mediaOwner',
        tag: 'uikit core data',
        subTag: 'media',
      );
      ZegoExpressEngine.instance.mutePlayStreamAudio(
        mediaOwner.auxChannel.streamID,
        mute,
      );
    }
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
        streamSEIKeyMediaSoundLevel: mediaSoundLevel,
      },
      ZegoStreamType.media.channel,
    );
  }

  void uninitMediaEventHandle() {
    ZegoLoggerService.logInfo(
      'uninitMediaEventHandle',
      tag: 'uikit core data',
      subTag: 'media',
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
      tag: 'uikit core data',
      subTag: 'media',
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
      tag: 'uikit core data',
      subTag: 'media',
    );

    mediaState.value = MediaPlayStateExtension.fromZego(state);

    _syncMediaInfoBySEI();
  }

  void onMediaPlayerNetworkEvent(
    ZegoMediaPlayer mediaPlayer,
    ZegoMediaPlayerNetworkEvent networkEvent,
  ) {
    ZegoLoggerService.logInfo(
      'onMediaPlayerNetworkEvent $networkEvent',
      tag: 'uikit core data',
      subTag: 'media',
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
    //   tag: 'uikit core data',
    //   subTag: 'media',
    // );
  }

  void onRemoteMediaTypeUpdate(String streamID, int remoteMediaType) {
    ZegoLoggerService.logInfo(
      'onRemoteMediaTypeUpdate $remoteMediaType',
      tag: 'uikit core data',
      subTag: 'media',
    );

    mediaType.value = MediaType.values[remoteMediaType];
  }

  void onMediaPlayerRecvSEIFromSDK(
    String streamID,
    String userID,
    Map<String, dynamic> sei,
  ) {
    mediaOwnerID ??= ZegoUIKitCore.shared.coreData.streamDic[streamID] ?? '';
    final isLocalMedia =
        mediaOwnerID == ZegoUIKitCore.shared.coreData.localUser.id;

    if (sei.keys.contains(streamSEIKeyMediaStatus)) {
      final playState =
          MediaPlayState.values[sei[streamSEIKeyMediaStatus] as int];
      if (isLocalMedia) {
        /// remote user control local media
        switch (playState) {
          case MediaPlayState.NoPlay:
          case MediaPlayState.LoadReady:
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
        /// sync media owner play state
        mediaState.value = playState;
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
      tag: 'uikit core data',
      subTag: 'media',
    );
  }

  void onMediaPlayerFirstFrameEvent(
    ZegoMediaPlayer mediaPlayer,
    ZegoMediaPlayerFirstFrameEvent event,
  ) {
    ZegoLoggerService.logInfo(
      'onMediaPlayerFirstFrameEvent $event',
      tag: 'uikit core data',
      subTag: 'media',
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
                tag: 'uikit core data',
                subTag: 'media',
              );
            },
          ))
              ?.files ??
          [];
      ZegoLoggerService.logInfo(
        'pick files: $ret, ${DateTime.now().millisecondsSinceEpoch}',
        tag: 'uikit core data',
        subTag: 'media',
      );
      return ret;
    } on PlatformException catch (e) {
      ZegoLoggerService.logInfo(
        'pick files Unsupported operation $e',
        tag: 'uikit core data',
        subTag: 'media',
      );
    } catch (e) {
      ZegoLoggerService.logInfo(
        'pick files exception:$e',
        tag: 'uikit core data',
        subTag: 'media',
      );
    }

    return [];
  }
}
