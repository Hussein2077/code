
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/command.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/data/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/data/network_timestamp.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/data/screen_sharing.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/data/stream.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/data/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

/// @nodoc
class ZegoUIKitCoreData
    with
        ZegoUIKitCoreDataStream,
        ZegoUIKitCoreDataUser,
        ZegoUIKitCoreDataNetworkTimestamp,
        ZegoUIKitCoreDataMedia,
        ZegoUIKitCoreDataScreenSharing {
  Timer? mixerSEITimer;

  ZegoUIKitCoreRoom room = ZegoUIKitCoreRoom('');

  StreamController<ZegoInRoomCommandReceivedData>
      customCommandReceivedStreamCtrl =
      StreamController<ZegoInRoomCommandReceivedData>.broadcast();
  StreamController<ZegoNetworkMode> networkModeStreamCtrl =
      StreamController<ZegoNetworkMode>.broadcast();

  ZegoEffectsBeautyParam beautyParam = ZegoEffectsBeautyParam.defaultParam();

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
