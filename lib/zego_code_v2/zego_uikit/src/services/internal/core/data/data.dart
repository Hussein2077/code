

import 'dart:async';
import 'dart:convert';

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/audio_video_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/command.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/data/media.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/data/network_timestamp.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/data/screen_sharing.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import 'package:flutter/services.dart';

import '../../../../../../zego_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

/// @nodoc
class ZegoUIKitCoreData
    with
        ZegoUIKitCoreDataNetworkTimestamp,
        ZegoUIKitCoreDataMedia,
        ZegoUIKitCoreDataScreenSharing {
  ZegoUIKitCoreUser localUser = ZegoUIKitCoreUser.localDefault();

  final List<ZegoUIKitCoreUser> remoteUsersList = [];

  final Map<String, ZegoUIKitCoreMixerStream> mixerStreamDic =
      {}; // key:stream_id

  Timer? mixerSEITimer;

  final Map<String, String> streamDic = {}; // stream_id:user_id

  ZegoUIKitCoreRoom room = ZegoUIKitCoreRoom('');

  bool isAllPlayStreamAudioVideoMuted = false;

  ZegoAudioVideoResourceMode playResourceMode =
      ZegoAudioVideoResourceMode.Default;

  StreamController<List<ZegoUIKitCoreUser>> userJoinStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();
  StreamController<List<ZegoUIKitCoreUser>> userLeaveStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();
  StreamController<List<ZegoUIKitCoreUser>> userListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();

  StreamController<List<ZegoUIKitCoreUser>> audioVideoListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();
  StreamController<List<ZegoUIKitCoreUser>> screenSharingListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();
  StreamController<List<ZegoUIKitCoreUser>> mediaListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();

  StreamController<String> meRemovedFromRoomStreamCtrl =
      StreamController<String>.broadcast();
  StreamController<ZegoInRoomCommandReceivedData>
      customCommandReceivedStreamCtrl =
      StreamController<ZegoInRoomCommandReceivedData>.broadcast();
  StreamController<ZegoNetworkMode> networkModeStreamCtrl =
      StreamController<ZegoNetworkMode>.broadcast();

  StreamController<String> turnOnYourCameraRequestStreamCtrl =
      StreamController<String>.broadcast();
  StreamController<ZegoUIKitReceiveTurnOnLocalMicrophoneEvent>
      turnOnYourMicrophoneRequestStreamCtrl =
      StreamController<ZegoUIKitReceiveTurnOnLocalMicrophoneEvent>.broadcast();

  StreamController<ZegoUIKitReceiveSEIEvent> receiveSEIStreamCtrl =
      StreamController<ZegoUIKitReceiveSEIEvent>.broadcast();

  ZegoUIKitVideoConfig pushVideoConfig = ZegoUIKitVideoConfig();

  ZegoEffectsBeautyParam beautyParam = ZegoEffectsBeautyParam.defaultParam();

  ZegoStreamResourceMode get sdkPlayResourceMode {
    switch (playResourceMode) {
      case ZegoAudioVideoResourceMode.Default:
        return ZegoStreamResourceMode.Default;
      case ZegoAudioVideoResourceMode.CDNOnly:
        return ZegoStreamResourceMode.OnlyCDN;
      case ZegoAudioVideoResourceMode.L3Only:
        return ZegoStreamResourceMode.OnlyL3;
      case ZegoAudioVideoResourceMode.RTCOnly:
        return ZegoStreamResourceMode.OnlyRTC;
      case ZegoAudioVideoResourceMode.CDNPlus:
        return ZegoStreamResourceMode.CDNPlus;
    }
  }

  String getLocalStreamID(ZegoStreamType streamType) {
    return getLocalStreamChannel(streamType).streamID;
  }

  ZegoUIKitCoreStreamInfo getLocalStreamChannel(ZegoStreamType streamType) {
    return getUserStreamChannel(localUser, streamType);
  }

  ZegoUIKitCoreStreamInfo getUserStreamChannel(
    ZegoUIKitCoreUser user,
    ZegoStreamType streamType,
  ) {
    switch (streamType) {
      case ZegoStreamType.main:
        return user.mainChannel;
      case ZegoStreamType.media:
      case ZegoStreamType.screenSharing:
      case ZegoStreamType.mix:
        return user.auxChannel;
      // return user.thirdChannel;
    }
  }

  ZegoStreamType getStreamTypeByID(String streamID) {
    if (streamID.endsWith(ZegoStreamType.main.text)) {
      return ZegoStreamType.main;
    } else if (streamID.endsWith(ZegoStreamType.media.text)) {
      return ZegoStreamType.media;
    } else if (streamID.endsWith(ZegoStreamType.screenSharing.text)) {
      return ZegoStreamType.screenSharing;
    } else if (streamID.endsWith(ZegoStreamType.mix.text)) {
      return ZegoStreamType.mix;
    }

    assert(false);
    return ZegoStreamType.main;
  }

  ZegoUIKitCoreUser getUser(String userID) {
    if (userID == ZegoUIKitCore.shared.coreData.localUser.id) {
      return ZegoUIKitCore.shared.coreData.localUser;
    } else {
      return ZegoUIKitCore.shared.coreData.remoteUsersList.firstWhere(
          (user) => user.id == userID,
          orElse: ZegoUIKitCoreUser.empty);
    }
  }

  void clearStream() {
    ZegoLoggerService.logInfo(
      'clear stream',
      tag: 'uikit',
      subTag: 'core data',
    );

    if (isScreenSharing.value) {
      stopSharingScreen();
    }

    for (final user in remoteUsersList) {
      if (user.mainChannel.streamID.isNotEmpty) {
        stopPlayingStream(user.mainChannel.streamID);
      }
      user.destroyTextureRenderer(streamType: ZegoStreamType.main);

      if (user.auxChannel.streamID.isNotEmpty) {
        stopPlayingStream(user.auxChannel.streamID);
      }
      user.destroyTextureRenderer(streamType: ZegoStreamType.screenSharing);
    }

    if (localUser.mainChannel.streamID.isNotEmpty) {
      stopPublishingStream(streamType: ZegoStreamType.main);
      localUser.destroyTextureRenderer(streamType: ZegoStreamType.main);
    }
    if (localUser.auxChannel.streamID.isNotEmpty) {
      stopPublishingStream(streamType: ZegoStreamType.screenSharing);
      localUser.destroyTextureRenderer(
          streamType: ZegoStreamType.screenSharing);
    }
  }

  void clear() {
    ZegoLoggerService.logInfo(
      'clear',
      tag: 'uikit',
      subTag: 'core data',
    );

    clearStream();
    clearMedia();

    isAllPlayStreamAudioVideoMuted = false;

    remoteUsersList.clear();
    streamDic.clear();
    room.clear();
  }

  ZegoUIKitCoreUser login(String id, String name) {
    ZegoLoggerService.logInfo(
      'login, id:"$id", name:$name',
      tag: 'uikit',
      subTag: 'core data',
    );
    if (id.isEmpty || name.isEmpty) {
      ZegoLoggerService.logError(
        'login params is not valid',
        tag: 'uikit',
        subTag: 'core data',
      );
    }

    localUser
      ..id = id
      ..name = name;

    userJoinStreamCtrl.add([localUser]);
    final allUserList = [localUser, ...remoteUsersList];
    userListStreamCtrl.add(allUserList);

    return localUser;
  }

  void logout() {
    ZegoLoggerService.logInfo(
      'logout',
      tag: 'uikit',
      subTag: 'core data',
    );

    localUser
      ..id = ''
      ..name = '';

    userLeaveStreamCtrl.add([localUser]);
    userListStreamCtrl.add(remoteUsersList);
  }

  void setRoom(
    String roomID, {
    bool markAsLargeRoom = false,
  }) {
    ZegoLoggerService.logInfo(
      'set room:"$roomID", markAsLargeRoom:$markAsLargeRoom}',
      tag: 'uikit',
      subTag: 'core data',
    );

    if (roomID.isEmpty) {
      ZegoLoggerService.logError(
        'room id is empty',
        tag: 'uikit',
        subTag: 'core data',
      );
    }

    room
      ..id = roomID
      ..markAsLargeRoom = markAsLargeRoom;
  }

  Future<void> startPreview() async {
    ZegoLoggerService.logInfo(
      'start preview',
      tag: 'uikit',
      subTag: 'core data',
    );

    createLocalUserVideoView(
      streamType: ZegoStreamType.main,
      onViewCreated: onViewCreatedByStartPreview,
    );
  }

  Future<void> onViewCreatedByStartPreview(ZegoStreamType streamType) async {
    ZegoLoggerService.logInfo(
      'start preview, on view created',
      tag: 'uikit',
      subTag: 'core data',
    );

    assert(localUser.mainChannel.viewID != -1);

    final previewCanvas = ZegoCanvas(
      localUser.mainChannel.viewID,
      viewMode: pushVideoConfig.useVideoViewAspectFill
          ? ZegoViewMode.AspectFill
          : ZegoViewMode.AspectFit,
    );

    ZegoExpressEngine.instance
      ..enableCamera(localUser.camera.value)
      ..startPreview(canvas: previewCanvas);
  }

  Future<void> stopPreview() async {
    ZegoLoggerService.logInfo(
      'stop preview',
      tag: 'uikit',
      subTag: 'core data',
    );

    localUser.destroyTextureRenderer(streamType: ZegoStreamType.main);

    ZegoExpressEngine.instance.stopPreview();
  }

  Future<void> startPublishingStream({
    required ZegoStreamType streamType,
  }) async {
    final targetStreamID = getLocalStreamID(streamType);
    if (targetStreamID.isNotEmpty) {
      ZegoLoggerService.logWarn(
        'startPublishingStream local user stream id($targetStreamID) of $streamType is not empty',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    final localStreamChannel = getLocalStreamChannel(streamType);
    localStreamChannel
      ..streamID = generateStreamID(localUser.id, room.id, streamType)
      ..streamTimestamp = networkDateTime_.millisecondsSinceEpoch;
    streamDic[localStreamChannel.streamID] = localUser.id;

    ZegoLoggerService.logInfo(
      'stream dict add $streamType ${localStreamChannel.streamID} for ${localUser.id}, '
      'now stream dict:$streamDic',
      tag: 'uikit',
      subTag: 'core data',
    );

    ZegoLoggerService.logInfo(
      'startPublishingStream ${localStreamChannel.streamID}',
      tag: 'uikit',
      subTag: 'core data',
    );

    createLocalUserVideoView(
      streamType: streamType,
      onViewCreated: onViewCreatedByStartPublishingStream,
    );
  }

  Future<void> onViewCreatedByStartPublishingStream(
    ZegoStreamType streamType,
  ) async {
    assert(getLocalStreamChannel(streamType).viewID != -1);
    final previewCanvas = ZegoCanvas(
      getLocalStreamChannel(streamType).viewID,
      viewMode: ZegoStreamType.media == streamType
          ? ZegoViewMode.AspectFit
          : (pushVideoConfig.useVideoViewAspectFill
              ? ZegoViewMode.AspectFill
              : ZegoViewMode.AspectFit),
    );

    /// advance config
    switch (streamType) {
      case ZegoStreamType.main:
        await ZegoExpressEngine.instance.enableCamera(localUser.camera.value);
        await ZegoExpressEngine.instance
            .muteMicrophone(!localUser.microphone.value);
        await ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
        break;
      case ZegoStreamType.media:
        currentMediaPlayer?.setPlayerCanvas(previewCanvas);

        await ZegoExpressEngine.instance.setVideoSource(
          ZegoVideoSourceType.Player,
          channel: streamType.channel,
        );
        await ZegoExpressEngine.instance.setAudioSource(
          ZegoAudioSourceType.MediaPlayer,
          channel: streamType.channel,
        );

        await ZegoExpressEngine.instance.setVideoConfig(
          getPreferMediaVideoConfig(),
          channel: streamType.channel,
        );
        break;
      case ZegoStreamType.screenSharing:
      case ZegoStreamType.mix:
        await ZegoExpressEngine.instance.setVideoConfig(
          ZegoVideoConfig.preset(ZegoVideoConfigPreset.Preset540P),
          channel: streamType.channel,
        );
        break;
    }

    await ZegoExpressEngine.instance
        .startPublishingStream(
      getLocalStreamID(streamType),
      channel: streamType.channel,
    )
        .then((value) {
      audioVideoListStreamCtrl.add(getAudioVideoList());

      if (ZegoStreamType.screenSharing == streamType) {
        screenSharingListStreamCtrl
            .add(getAudioVideoList(streamType: streamType));
      } else if (ZegoStreamType.media == streamType) {
        mediaListStreamCtrl.add(getAudioVideoList(streamType: streamType));
      }
    });
  }

  Future<void> stopPublishingStream({
    required ZegoStreamType streamType,
  }) async {
    final targetStreamID = getLocalStreamID(streamType);
    ZegoLoggerService.logInfo(
      'stopPublishingStream $streamType $targetStreamID}',
      tag: 'uikit',
      subTag: 'core data',
    );

    if (targetStreamID.isEmpty) {
      ZegoLoggerService.logInfo(
        'stopPublishingStream stream id is empty',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    streamDic.remove(targetStreamID);
    ZegoLoggerService.logInfo(
      'stream dict remove $targetStreamID, now stream dict:$streamDic',
      tag: 'uikit',
      subTag: 'core data',
    );

    getLocalStreamChannel(streamType)
      ..streamID = ''
      ..streamTimestamp = 0;

    localUser.destroyTextureRenderer(streamType: streamType);

    switch (streamType) {
      case ZegoStreamType.main:
        await ZegoExpressEngine.instance.stopPreview();
        break;
      case ZegoStreamType.media:
        await ZegoExpressEngine.instance.setVideoSource(
          ZegoVideoSourceType.None,
          channel: streamType.channel,
        );
        await ZegoExpressEngine.instance.setAudioSource(
          ZegoAudioSourceType.Default,
          channel: streamType.channel,
        );
        break;
      case ZegoStreamType.screenSharing:
        await ZegoExpressEngine.instance.setVideoSource(
          ZegoVideoSourceType.None,
          channel: streamType.channel,
        );
        break;
      default:
        break;
    }

    await ZegoExpressEngine.instance
        .stopPublishingStream(channel: streamType.channel)
        .then((value) {
      audioVideoListStreamCtrl.add(getAudioVideoList());
      screenSharingListStreamCtrl
          .add(getAudioVideoList(streamType: ZegoStreamType.screenSharing));
      mediaListStreamCtrl
          .add(getAudioVideoList(streamType: ZegoStreamType.media));
    });
  }

  Future<void> startPublishOrNot() async {
    if (room.id.isEmpty) {
      ZegoLoggerService.logError(
        'startPublishOrNot room id is empty',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    if (localUser.camera.value ||
        localUser.microphone.value ||
        localUser.microphoneMuteMode.value) {
      startPublishingStream(
        streamType: ZegoStreamType.main,
      );
    } else {
      if (localUser.mainChannel.streamID.isNotEmpty) {
        stopPublishingStream(
          streamType: ZegoStreamType.main,
        );
      }
    }
  }

  void createLocalUserVideoView({
    required ZegoStreamType streamType,
    required void Function(ZegoStreamType) onViewCreated,
  }) {
    final localStreamChannel = getLocalStreamChannel(streamType);
    if (-1 == localStreamChannel.viewID) {
      ZegoExpressEngine.instance.createCanvasView((viewID) {
        localStreamChannel.viewID = viewID;
        onViewCreated(streamType);

        if (ZegoStreamType.main == streamType) {
          audioVideoListStreamCtrl.add(getAudioVideoList());
        } else if (ZegoStreamType.media == streamType) {
          mediaListStreamCtrl
              .add(getAudioVideoList(streamType: ZegoStreamType.media));
        }
      }).then((widget) {
        localStreamChannel.view.value = widget;
      });
    } else {
      //  user view had created
      onViewCreated(streamType);
    }
  }

  ZegoUIKitCoreUser removeUser(String uid) {
    final targetIndex = remoteUsersList.indexWhere((user) => uid == user.id);
    if (-1 == targetIndex) {
      return ZegoUIKitCoreUser.empty();
    }

    final targetUser = remoteUsersList.removeAt(targetIndex);
    if (targetUser.mainChannel.streamID.isNotEmpty) {
      stopPlayingStream(targetUser.mainChannel.streamID);
    }
    if (targetUser.auxChannel.streamID.isNotEmpty) {
      stopPlayingStream(targetUser.auxChannel.streamID);
    }
    if (targetUser.thirdChannel.streamID.isNotEmpty) {
      stopPlayingStream(targetUser.thirdChannel.streamID);
    }

    return targetUser;
  }

  Future<void> muteUserAudioVideo(String userID, bool mute) async {
    ZegoLoggerService.logInfo(
      'muteUserAudioVideo, userID: $userID, mute: $mute',
      tag: 'uikit',
      subTag: 'core data',
    );

    final targetUserIndex =
        remoteUsersList.indexWhere((user) => userID == user.id);
    if (-1 == targetUserIndex) {
      ZegoLoggerService.logError(
        "muteUserAudioVideo, can't find this user, userID: $userID",
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    final streamID = remoteUsersList[targetUserIndex].mainChannel.streamID;
    if (streamID.isEmpty) {
      ZegoLoggerService.logError(
        "muteUserAudioVideo, can't find this user's stream, userID: $userID",
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }
    ZegoExpressEngine.instance.mutePlayStreamAudio(streamID, mute);
    ZegoExpressEngine.instance.mutePlayStreamVideo(streamID, mute);
  }

  Future<void> muteAllPlayStreamAudioVideo(bool isMuted) async {
    ZegoLoggerService.logInfo(
      'mute all play stream audio video: $isMuted',
      tag: 'uikit',
      subTag: 'core data',
    );

    isAllPlayStreamAudioVideoMuted = isMuted;

    ZegoExpressEngine.instance
        .muteAllPlayStreamVideo(isAllPlayStreamAudioVideoMuted);
    ZegoExpressEngine.instance
        .muteAllPlayStreamAudio(isAllPlayStreamAudioVideoMuted);

    streamDic.forEach((streamID, userID) {
      if (isMuted) {
        // stop playing stream
        ZegoExpressEngine.instance.stopPlayingStream(streamID);
      } else {
        if (localUser.id != userID) {
          startPlayingStream(streamID, userID);
        }
      }
    });
  }

  /// will change data variables
  Future<void> startPlayingStream(String streamID, String streamUserID) async {
    ZegoLoggerService.logInfo(
      'start play stream id: $streamID, user id:$streamUserID',
      tag: 'uikit',
      subTag: 'core data',
    );

    final targetUserIndex =
        remoteUsersList.indexWhere((user) => streamUserID == user.id);
    assert(-1 != targetUserIndex);
    final targetUser = remoteUsersList[targetUserIndex];

    final streamType = getStreamTypeByID(streamID);
    final userStreamChannel = getUserStreamChannel(targetUser, streamType);
    userStreamChannel
      ..streamID = streamID
      ..streamTimestamp = networkDateTime_.millisecondsSinceEpoch;

    ZegoExpressEngine.instance.createCanvasView((viewID) {
      userStreamChannel.viewID = viewID;

      final canvas = ZegoCanvas(
        viewID,
        viewMode: ZegoStreamType.main == streamType
            ? (pushVideoConfig.useVideoViewAspectFill
                ? ZegoViewMode.AspectFill
                : ZegoViewMode.AspectFit)

            /// screen share/media default AspectFit
            : ZegoViewMode.AspectFit,
      );
      final playConfig = ZegoPlayerConfig(sdkPlayResourceMode);
      ZegoExpressEngine.instance
          .startPlayingStream(
        streamID,
        canvas: canvas,
        config: playConfig,
      )
          .then((value) {
        if (ZegoStreamType.main == streamType) {
          audioVideoListStreamCtrl.add(getAudioVideoList());
        } else if (ZegoStreamType.screenSharing == streamType) {
          screenSharingListStreamCtrl
              .add(getAudioVideoList(streamType: streamType));
        } else if (ZegoStreamType.media == streamType) {
          mediaListStreamCtrl.add(getAudioVideoList(streamType: streamType));
        }
      });
    }).then((widget) {
      userStreamChannel.view.value = widget;
    });
  }

  /// will change data variables
  void stopPlayingStream(String streamID) {
    ZegoLoggerService.logInfo(
      'stop play stream id: $streamID',
      tag: 'uikit',
      subTag: 'core data',
    );
    assert(streamID.isNotEmpty);

    // stop playing stream
    ZegoExpressEngine.instance.stopPlayingStream(streamID);

    final targetUserID =
        streamDic.containsKey(streamID) ? streamDic[streamID] : '';
    ZegoLoggerService.logInfo(
      'stopped play stream id $streamID, user id  is: $targetUserID',
      tag: 'uikit',
      subTag: 'core data',
    );
    final targetUserIndex =
        remoteUsersList.indexWhere((user) => targetUserID == user.id);
    if (-1 != targetUserIndex) {
      final targetUser = remoteUsersList[targetUserIndex];

      final streamType = getStreamTypeByID(streamID);
      getUserStreamChannel(targetUser, streamType)
        ..streamID = ''
        ..streamTimestamp = 0;
      targetUser
        ..destroyTextureRenderer(streamType: streamType)
        ..camera.value = false
        ..microphone.value = false
        ..microphoneMuteMode.value = false;
    }

    // clear streamID
    streamDic.remove(streamID);
    ZegoLoggerService.logInfo(
      'stream dict remove $streamID, $streamDic',
      tag: 'uikit',
      subTag: 'core data',
    );
  }

  List<ZegoUIKitCoreUser> getAudioVideoList({
    ZegoStreamType streamType = ZegoStreamType.main,
  }) {
    return streamDic.entries
        .where((value) => value.key.endsWith(streamType.text))
        .map((entry) {
      final targetUserID = entry.value;
      if (targetUserID == localUser.id) {
        return localUser;
      }
      return remoteUsersList.firstWhere((user) => targetUserID == user.id,
          orElse: ZegoUIKitCoreUser.empty);
    }).where((user) {
      if (user.id.isEmpty) {
        return false;
      }

      if (streamType == ZegoStreamType.main) {
        /// only open camera or microphone
        return user.camera.value ||

            /// if mic is in mute mode, same as open state
            (user.microphone.value || user.microphoneMuteMode.value);
      }

      return true;
    }).toList();
  }

  void startPlayAnotherRoomAudioVideo(
    String roomID,
    String userID,
    String userName,
  ) {
    ZegoLoggerService.logError(
      'startPlayAnotherRoomAudioVideo, roomID:$roomID, userID:$userID, userName:$userName',
      tag: 'uikit',
      subTag: 'core',
    );

    var targetUserIndex =
        remoteUsersList.indexWhere((user) => userID == user.id);
    if (-1 == targetUserIndex) {
      remoteUsersList
          .add(ZegoUIKitCoreUser(userID, userName)..isAnotherRoomUser = true);
    }
    targetUserIndex = remoteUsersList.indexWhere((user) => userID == user.id);

    final streamID = generateStreamID(userID, roomID, ZegoStreamType.main);
    streamDic[streamID] = userID;
    remoteUsersList[targetUserIndex]
      ..mainChannel.streamID = streamID
      ..mainChannel.streamTimestamp = networkDateTime_.millisecondsSinceEpoch;

    ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteUsersList[targetUserIndex].mainChannel.viewID = viewID;
      final canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((widget) {
      assert(widget != null);
      remoteUsersList[targetUserIndex].mainChannel.view.value = widget;
    });
  }

  void stopPlayAnotherRoomAudioVideo(String userID) {
    ZegoLoggerService.logInfo(
      'stopPlayAnotherRoomAudioVideo, userID:$userID',
      tag: 'uikit',
      subTag: 'core data',
    );

    final targetUserIndex =
        remoteUsersList.indexWhere((user) => userID == user.id);
    if (-1 != targetUserIndex) {
      final targetUser = remoteUsersList[targetUserIndex];
      final streamID = remoteUsersList[targetUserIndex].mainChannel.streamID;
      ZegoExpressEngine.instance.stopPlayingStream(streamID);

      targetUser
        ..mainChannel.streamID = ''
        ..mainChannel.streamTimestamp = 0
        ..destroyTextureRenderer(streamType: ZegoStreamType.main);

      targetUser.camera.value = false;
      targetUser.microphone.value = false;
      targetUser.microphoneMuteMode.value = false;
      targetUser.mainChannel.soundLevel.add(0);
      streamDic.remove(streamID);
      remoteUsersList.removeWhere((user) => userID == user.id);
      ZegoLoggerService.logInfo(
        'stopPlayAnotherRoomAudioVideo, userID:$userID, streamID:$streamID',
        tag: 'uikit',
        subTag: 'core data',
      );
    } else {
      ZegoLoggerService.logWarn(
        "stopPlayAnotherRoomAudioVideo, can't find this user, userID:$userID",
        tag: 'uikit',
        subTag: 'core data',
      );
    }
  }

  void muteAudio(String userID, bool mute) {
    ZegoLoggerService.logInfo(
      'muteAudio, userID:$userID, mute:$mute',
      tag: 'uikit',
      subTag: 'core data',
    );
    final targetUserIndex =
        remoteUsersList.indexWhere((user) => userID == user.id);
    if (-1 != targetUserIndex) {
      final streamID = remoteUsersList[targetUserIndex].mainChannel.streamID;
      ZegoExpressEngine.instance.mutePlayStreamAudio(streamID, mute);
      ZegoLoggerService.logInfo(
        'muteAudio, userID:$userID, streamID:$streamID',
        tag: 'uikit',
        subTag: 'core data',
      );
    } else {
      ZegoLoggerService.logWarn(
        "muteAudio, can't find this user, userID:$userID",
        tag: 'uikit',
        subTag: 'core data',
      );
    }
  }

  Future<void> startPlayMixAudioVideo(
      String mixerID, List<String> users) async {
    ZegoLoggerService.logWarn(
      'startPlayMixAudioVideo, mixerID:$mixerID, users:$users',
      tag: 'uikit',
      subTag: 'core data',
    );
    mixerStreamDic[mixerID] = ZegoUIKitCoreMixerStream(
      mixerID,
      users.map((e) => ZegoUIKitCoreUser(e, '')).toList(),
    );
    ZegoExpressEngine.instance.createCanvasView((viewID) {
      mixerStreamDic[mixerID]!.viewID = viewID;
      final canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(mixerID, canvas: canvas);
      Future.delayed(const Duration(seconds: 3), () {
        mixerStreamDic[mixerID]?.loaded.value = true;
      });
    }).then((widget) {
      assert(widget != null);
      mixerStreamDic[mixerID]!.view.value = widget;
    });
  }

  Future<void> stopPlayMixAudioVideo(String mixerID) async {
    ZegoLoggerService.logInfo(
      'stopPlayMixAudioVideo, mixerID:$mixerID',
      tag: 'uikit',
      subTag: 'core data',
    );
    ZegoExpressEngine.instance.stopPlayingStream(mixerID);
    mixerStreamDic[mixerID]!.destroyTextureRenderer();
    mixerStreamDic.remove(mixerID);
  }

  Future<void> sendSEI(
    String typeIdentifier,
    Map<String, dynamic> sei,
    ZegoPublishChannel? channel,
  ) async {
    final dataJson = jsonEncode({
      streamSEIKeyUserID: localUser.id,
      streamSEIKeyTypeIdentifier: typeIdentifier,
      streamSEIKeySEI: sei,
    });
    final dataBytes = Uint8List.fromList(utf8.encode(dataJson));
    return ZegoExpressEngine.instance.sendSEI(
      dataBytes,
      dataBytes.length,
      channel: channel,
    );
  }
}
