// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/data/data.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

extension ZegoUIKitCoreDataEventHandler on ZegoUIKitCoreData {
  Future<void> onRoomStreamUpdate(
    String roomID,
    ZegoUpdateType updateType,
    List<ZegoStream> streamList,
    Map<String, dynamic> extendedData,
  ) async {
    ZegoLoggerService.logInfo(
      'onRoomStreamUpdate, roomID:$roomID, update type:$updateType'
      ", stream list:${streamList.map((e) => "stream id:${e.streamID}, extra info${e.extraInfo}, user id:${e.user.userID}")},"
      ' extended data:$extendedData',
      tag: 'uikit',
      subTag: 'core data',
    );

    if (updateType == ZegoUpdateType.Add) {
      for (final stream in streamList) {
        streamDic[stream.streamID] = stream.user.userID;
        ZegoLoggerService.logInfo(
          'stream dict add ${stream.streamID} for ${stream.user.userID}, $streamDic',
          tag: 'uikit',
          subTag: 'core data',
        );

        if (-1 ==
            remoteUsersList
                .indexWhere((user) => stream.user.userID == user.id)) {
          /// user is not exist before stream added
          ZegoLoggerService.logInfo(
            "stream's user ${stream.user.userID}  ${stream.user.userName} is not exist, create",
            tag: 'uikit',
            subTag: 'core data',
          );

          final targetUser = ZegoUIKitCoreUser.fromZego(stream.user);
          final streamType = getStreamTypeByID(stream.streamID);
          getUserStreamChannel(targetUser, streamType)
            ..streamID = stream.streamID
            ..streamTimestamp = networkDateTime_.millisecondsSinceEpoch;
          remoteUsersList.add(targetUser);
        }

        if (isAllPlayStreamAudioVideoMuted) {
          ZegoLoggerService.logInfo(
            'audio video is not play enabled, user id:${stream.user.userID}, stream id:${stream.streamID}',
            tag: 'uikit',
            subTag: 'core data',
          );
        } else {
          await startPlayingStream(stream.streamID, stream.user.userID);
        }
      }

      onRoomStreamExtraInfoUpdate(roomID, streamList);
    } else {
      for (final stream in streamList) {
        stopPlayingStream(stream.streamID);
      }
    }

    final streamIDs = streamList.map((e) => e.streamID).toList();
    if (-1 !=
        streamIDs.indexWhere(
            (streamID) => streamID.endsWith(ZegoStreamType.main.text))) {
      audioVideoListStreamCtrl.add(getAudioVideoList());
    }
    if (-1 !=
        streamIDs.indexWhere((streamID) =>
            streamID.endsWith(ZegoStreamType.screenSharing.text))) {
      screenSharingListStreamCtrl
          .add(getAudioVideoList(streamType: ZegoStreamType.screenSharing));
    }
    if (-1 !=
        streamIDs.indexWhere(
            (streamID) => streamID.endsWith(ZegoStreamType.media.text))) {
      mediaListStreamCtrl
          .add(getAudioVideoList(streamType: ZegoStreamType.media));
    }
  }

  void onRoomUserUpdate(
    String roomID,
    ZegoUpdateType updateType,
    List<ZegoUser> userList,
  ) {
    ZegoLoggerService.logInfo(
      'onRoomUserUpdate, room id:"$roomID", update type:$updateType'
      "user list:${userList.map((user) => '"${user.userID}":${user.userName}, ')}",
      tag: 'uikit',
      subTag: 'core data',
    );

    if (updateType == ZegoUpdateType.Add) {
      for (final _user in userList) {
        final targetUserIndex =
            remoteUsersList.indexWhere((user) => _user.userID == user.id);
        if (-1 != targetUserIndex) {
          continue;
        }

        remoteUsersList.add(ZegoUIKitCoreUser.fromZego(_user));
      }

      if (remoteUsersList.length >= 499) {
        /// turn to be a large room after more than 500 people, even if less than 500 people behind
        ZegoLoggerService.logInfo(
          'users is more than 500, turn to be a large room',
          tag: 'uikit',
          subTag: 'core data',
        );
        room.isLargeRoom = true;
      }

      userJoinStreamCtrl.add(userList.map(ZegoUIKitCoreUser.fromZego).toList());
    } else {
      for (final user in userList) {
        removeUser(user.userID);
      }

      userLeaveStreamCtrl
          .add(userList.map(ZegoUIKitCoreUser.fromZego).toList());
    }

    final allUserList = [localUser, ...remoteUsersList];
    userListStreamCtrl.add(allUserList);
  }

  void onPublisherStateUpdate(
    String streamID,
    ZegoPublisherState state,
    int errorCode,
    Map<String, dynamic> extendedData,
  ) {
    ZegoLoggerService.logInfo(
      'onPublisherStateUpdate, stream id:$streamID, state:$state, errorCode:$errorCode, extendedData:$extendedData',
      tag: 'uikit',
      subTag: 'core data',
    );
  }

  void onPlayerStateUpdate(
    String streamID,
    ZegoPlayerState state,
    int errorCode,
    Map<String, dynamic> extendedData,
  ) {
    ZegoLoggerService.logInfo(
      'onPlayerStateUpdate, stream id:$streamID, state:$state, errorCode:$errorCode, extendedData:$extendedData',
      tag: 'uikit',
      subTag: 'core data',
    );
  }


  void onRemoteMicStateUpdate(String streamID, ZegoRemoteDeviceState state) {
    ZegoLoggerService.logInfo(
      'onRemoteMicStateUpdate, stream $streamID, state:$state',
      tag: 'uikit',
      subTag: 'core data',
    );

    final streamType = getStreamTypeByID(streamID);
    if (ZegoStreamType.main != streamType) {
      ZegoLoggerService.logInfo(
        'onRemoteMicStateUpdate, stream type is not main',
        tag: 'uikit',
        subTag: 'core data',
      );

      return;
    }

    /// update users' camera state

    if (!streamDic.containsKey(streamID)) {
      ZegoLoggerService.logInfo(
        'onRemoteMicStateUpdate, stream $streamID is not exist',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    final targetUserIndex =
        remoteUsersList.indexWhere((user) => streamDic[streamID]! == user.id);
    if (-1 == targetUserIndex) {
      ZegoLoggerService.logInfo(
        'onRemoteMicStateUpdate, stream user $streamID is not exist',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    final targetUser = remoteUsersList[targetUserIndex];
    ZegoLoggerService.logInfo(
      'onRemoteMicStateUpdate, stream id:$streamID, user:$targetUser, state:$state',
      tag: 'uikit',
      subTag: 'core data',
    );
    final oldValue = targetUser.microphone.value;
    switch (state) {
      case ZegoRemoteDeviceState.Open:
        targetUser.microphone.value = true;
        targetUser.microphoneMuteMode.value = false;
        break;
      case ZegoRemoteDeviceState.NoAuthorization:
        targetUser.microphone.value = true;
        targetUser.microphoneMuteMode.value = false;
        break;
      case ZegoRemoteDeviceState.Mute:
        targetUser.microphone.value = false;
        targetUser.microphoneMuteMode.value = true;
        break;
      default:
        targetUser.microphone.value = false;
        targetUser.mainChannel.soundLevel.add(0);
    }

    if (oldValue != targetUser.microphone.value) {
      /// notify outside to update audio video list
      notifyStreamListControl(getStreamTypeByID(streamID));
    }
  }

  void onRemoteSoundLevelUpdate(Map<String, double> soundLevels) {
    soundLevels.forEach((streamID, soundLevel) {
      if (!streamDic.containsKey(streamID)) {
        if (mixerStreamDic.containsKey(streamID)) {
          return;
        }
        ZegoLoggerService.logInfo(
          'stream dic does not contain $streamID',
          tag: 'uikit',
          subTag: 'core data',
        );
        return;
      }

      final targetUserID = streamDic[streamID]!;
      final targetUserIndex =
          remoteUsersList.indexWhere((user) => targetUserID == user.id);
      if (-1 == targetUserIndex) {
        ZegoLoggerService.logInfo(
          'remote user does not contain $targetUserID',
          tag: 'uikit',
          subTag: 'core data',
        );
        return;
      }

      getUserStreamChannel(
              remoteUsersList[targetUserIndex], getStreamTypeByID(streamID))
          .soundLevel
          .add(soundLevel);
    });
  }

  void onCapturedSoundLevelUpdate(double level) {
    if (localUser.microphoneMuteMode.value) {
      return;
    }

    localUser.mainChannel.soundLevel.add(level);
  }

  void onAudioRouteChange(ZegoAudioRoute audioRoute) {
    localUser.audioRoute.value = audioRoute;
  }

  void onPlayerVideoSizeChanged(String streamID, int width, int height) {
    if (!streamDic.containsKey(streamID)) {
      ZegoLoggerService.logInfo(
        'onPlayerVideoSizeChanged, stream $streamID is not exist',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }
    final targetUserIndex =
        remoteUsersList.indexWhere((user) => streamDic[streamID]! == user.id);
    if (-1 == targetUserIndex) {
      ZegoLoggerService.logInfo(
        'onPlayerVideoSizeChanged, stream user $streamID is not exist',
        tag: 'uikit',
        subTag: 'core data',
      );
      return;
    }

    final targetUser = remoteUsersList[targetUserIndex];
    ZegoLoggerService.logInfo(
      'onPlayerVideoSizeChanged streamID: $streamID width: $width height: $height',
      tag: 'uikit',
      subTag: 'core data',
    );
    final size = Size(width.toDouble(), height.toDouble());
    final targetUserStreamChannel =
        getUserStreamChannel(targetUser, getStreamTypeByID(streamID));
    if (targetUserStreamChannel.viewSize.value != size) {
      targetUserStreamChannel.viewSize.value = size;
    }
  }

  void onRoomStateChanged(String roomID, ZegoRoomStateChangedReason reason,
      int errorCode, Map<String, dynamic> extendedData) {
    ZegoLoggerService.logInfo(
      'onRoomStateChanged roomID: $roomID, reason: $reason, errorCode: $errorCode, extendedData: $extendedData',
      tag: 'uikit',
      subTag: 'core data',
    );

    room.state.value = ZegoUIKitRoomState(reason, errorCode, extendedData);

    if (reason == ZegoRoomStateChangedReason.KickOut) {
      ZegoLoggerService.logInfo(
        'local user had been kick out by room state changed',
        tag: 'uikit',
        subTag: 'core data',
      );

      meRemovedFromRoomStreamCtrl.add('');
    }
  }

  void onRoomExtraInfoUpdate(
      String roomID, List<ZegoRoomExtraInfo> roomExtraInfoList) {
    room.roomExtraInfoHadArrived = true;

    final roomExtraInfoString = roomExtraInfoList.map((info) =>
        'key:${info.key}, value:${info.value}'
        ' update user:${info.updateUser.userID},${info.updateUser.userName}, update time:${info.updateTime}');
    ZegoLoggerService.logInfo(
      'onRoomExtraInfoUpdate roomID: $roomID,roomExtraInfoList: $roomExtraInfoString',
      tag: 'uikit',
      subTag: 'core data',
    );

    for (final extraInfo in roomExtraInfoList) {
      if (extraInfo.key == 'extra_info') {
        final properties = jsonDecode(extraInfo.value) as Map<String, dynamic>;

        ZegoLoggerService.logInfo(
          'update room properties: $properties',
          tag: 'uikit',
          subTag: 'core data',
        );

        final updateProperties = <String, RoomProperty>{};

        properties.forEach((key, v) {
          final value = v as String;

          if (room.properties.containsKey(key) &&
              room.properties[key]!.value == value) {
            ZegoLoggerService.logInfo(
              'room property not need update, key:$key, value:$value',
              tag: 'uikit',
              subTag: 'core data',
            );
            return;
          }

          ZegoLoggerService.logInfo(
            'room property update, key:$key, value:$value',
            tag: 'uikit',
            subTag: 'core data',
          );
          if (room.properties.containsKey(key)) {
            final property = room.properties[key]!;
            if (extraInfo.updateTime > property.updateTime) {
              room.properties[key]!.oldValue = room.properties[key]!.value;
              room.properties[key]!.value = value;
              room.properties[key]!.updateTime = extraInfo.updateTime;
              room.properties[key]!.updateUserID = extraInfo.updateUser.userID;
              room.properties[key]!.updateFromRemote = true;
            }
          } else {
            room.properties[key] = RoomProperty(
              key,
              value,
              extraInfo.updateTime,
              extraInfo.updateUser.userID,
              true,
            );
          }
          updateProperties[key] = room.properties[key]!;
          room.propertyUpdateStream.add(room.properties[key]!);
        });

        if (updateProperties.isNotEmpty) {
          room.propertiesUpdatedStream.add(updateProperties);
        }
      }
    }
  }

  void onIMRecvCustomCommand(String roomID, ZegoUser fromUser, String command) {
    ZegoLoggerService.logInfo(
      'onIMRecvCustomCommand roomID: $roomID, reason: ${fromUser.userID} ${fromUser.userName}, command:$command',
      tag: 'uikit',
      subTag: 'core data',
    );

    customCommandReceivedStreamCtrl.add(ZegoInRoomCommandReceivedData(
      fromUser: ZegoUIKitUser.fromZego(fromUser),
      command: command,
    ));
  }

  void onNetworkModeChanged(ZegoNetworkMode mode) {
    networkModeStreamCtrl.add(mode);
  }

  void onRoomStreamExtraInfoUpdate(String roomID, List<ZegoStream> streamList) {
    /*
    * {
    * "isCameraOn": true,
    * "isMicrophoneOn": true,
    * "hasAudio": true,
    * "hasVideo": true,
    * }
    * */

    ZegoLoggerService.logInfo(
      "onRoomStreamExtraInfoUpdate, roomID:$roomID, stream list:${streamList.map((e) => "stream id:${e.streamID}, extra info${e.extraInfo}, user id:${e.user.userID}")}",
      tag: 'uikit',
      subTag: 'core data',
    );
    for (final stream in streamList) {
      if (stream.extraInfo.isEmpty) {
        ZegoLoggerService.logInfo(
          'onRoomStreamExtraInfoUpdate extra info is empty',
          tag: 'uikit',
          subTag: 'core data',
        );
        continue;
      }

      final extraInfos = jsonDecode(stream.extraInfo) as Map<String, dynamic>;

      if (extraInfos.containsKey(streamExtraInfoMicrophoneKey)) {
        onRemoteMicStateUpdate(
          stream.streamID,
          extraInfos[streamExtraInfoMicrophoneKey]!
              ? ZegoRemoteDeviceState.Open
              : ZegoRemoteDeviceState.Mute,
        );
      }
      if (extraInfos.containsKey(streamSEIKeyMediaType)) {
        onRemoteMediaTypeUpdate(
          stream.streamID,
          extraInfos[streamSEIKeyMediaType] as int? ??
              MediaType.PureAudio.index,
        );
      }
    }
  }



  void onPlayerRecvAudioFirstFrame(String mixerID) {
    mixerStreamDic[mixerID]?.loaded.value = true;
  }

  void onPlayerRecvSEI(String streamID, Uint8List data) {
    final dataJson = utf8.decode(data.toList());
    try {
      final dataMap = jsonDecode(dataJson) as Map<String, dynamic>;
      final typeIdentifier = dataMap[streamSEIKeyTypeIdentifier] as String;
      final sei = dataMap[streamSEIKeySEI] as Map<String, dynamic>;
      final uid = dataMap[streamSEIKeyUserID] as String;
      if (typeIdentifier == ZegoUIKitInnerSEIType.mixerDeviceState.name &&
          streamID.endsWith(ZegoStreamType.mix.text)) {
        _updateMixerDeviceStateBySEI(streamID, uid, sei);
      } else if (typeIdentifier == ZegoUIKitInnerSEIType.mediaSyncInfo.name) {
        onMediaPlayerRecvSEIFromSDK(streamID, uid, sei);
      }
      receiveSEIStreamCtrl
          .add(ZegoUIKitReceiveSEIEvent(typeIdentifier, uid, sei));
    } catch (e) {
      ZegoLoggerService.logWarn(
        'onPlayerRecvSEI, decode sei failed, sei: $dataJson, stream id:$streamID',
        tag: 'uikit',
        subTag: 'core data',
      );
    }
  }

  void _updateMixerDeviceStateBySEI(
      String streamID, String userID, Map<String, dynamic> sei) {
    assert(mixerStreamDic.containsKey(streamID),
        'onPlayerRecvSEI, mixerStreamDic not contains streamID:$streamID');
    final userIndex =
        mixerStreamDic[streamID]!.users.indexWhere((user) => user.id == userID);
    if (userIndex == -1) {
      final user = ZegoUIKitCoreUser(userID, '');
      user.microphone.value = sei[streamSEIKeyMicrophone]!;
      mixerStreamDic[streamID]!.users.add(user);
    } else {
      final user = mixerStreamDic[streamID]!.users[userIndex];
      user.microphone.value = sei[streamSEIKeyMicrophone]!;
    }
  }
}
