// Dart imports:
import 'dart:async';

// Package imports:

import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/plugins/signaling/impl/core/data.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/plugins/signaling/impl/core/event.dart';

// Package imports:

class ZegoSignalingPluginCore with ZegoSignalingPluginCoreEvent {
  ZegoSignalingPluginCore._internal();

  static ZegoSignalingPluginCore shared = ZegoSignalingPluginCore._internal();
  ZegoSignalingPluginCoreData coreData = ZegoSignalingPluginCoreData();

  /// get version
  Future<String> getVersion() async {
    return ZegoPluginAdapter().signalingPlugin?.getVersion() ??
        Future.value('signalingPlugin:null');
  }

  /// init
  Future<void> init({required int appID, String appSign = ''}) async {
    initEvent();
    coreData.create(appID: appID, appSign: appSign);
  }

  /// uninit
  Future<void> uninit() async {
    uninitEvent();
    return coreData.destroy();
  }

  /// login
  Future<bool> login(String id, String name) async {
    return coreData.login(id, name);
  }

  /// logout
  Future<void> logout() async {
    await coreData.logout();
  }

  /// join room
  Future<ZegoSignalingPluginJoinRoomResult> joinRoom(
      String roomID, String roomName) async {
    return coreData.joinRoom(roomID, roomName);
  }

  /// leave room
  Future<void> leaveRoom() async {
    await coreData.leaveRoom();
  }
}
