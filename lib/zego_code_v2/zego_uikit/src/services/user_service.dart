

import 'dart:developer';

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/internal/core/defines.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';

mixin ZegoUserService {
  /// login
  void login(String id, String name) {
    ZegoUIKitCore.shared.login(id, name);
  }

  /// logout
  void logout() {
    ZegoUIKitCore.shared.logout();
  }

  /// get local user
  ZegoUIKitUser getLocalUser() {
    return ZegoUIKitCore.shared.coreData.localUser.toZegoUikitUser();
  }

  /// get all users, include local user and remote users
  List<ZegoUIKitUser> getAllUsers() {
    return [
      ZegoUIKitCore.shared.coreData.localUser,
      ...ZegoUIKitCore.shared.coreData.remoteUsersList
    ]
        .where((user) => !user.isAnotherRoomUser)
        .map((user) => user.toZegoUikitUser())
        .toList();
  }

  /// get remote users, not include local user
  List<ZegoUIKitUser> getRemoteUsers() {
    return ZegoUIKitCore.shared.coreData.remoteUsersList
        .where((user) => !user.isAnotherRoomUser)
        .map((user) => user.toZegoUikitUser())
        .toList();
  }

  /// get user by user id
  ZegoUIKitUser? getUser(String userID) {
    if (userID.isEmpty) {
      return null;
    }

    if (userID == ZegoUIKitCore.shared.coreData.localUser.id) {

      return ZegoUIKitCore.shared.coreData.localUser.toZegoUikitUser();
    } else {


      final queryUser = ZegoUIKitCore.shared.coreData.remoteUsersList
          .firstWhere((element) => element.id == userID,
              orElse: ZegoUIKitCoreUser.empty)
          .toZegoUikitUser();
      return queryUser.isEmpty() ? null : queryUser;
    }
  }

  /// get notifier of in-room user attributes
  ValueNotifier<Map<String, String>> getInRoomUserAttributesNotifier(
      String userID) {
    if (userID == ZegoUIKitCore.shared.coreData.localUser.id) {
      return ZegoUIKitCore.shared.coreData.localUser.inRoomAttributes;
    } else {
      return ZegoUIKitCore.shared.coreData.remoteUsersList
          .firstWhere((user) => user.id == userID,
              orElse: ZegoUIKitCoreUser.empty)
          .inRoomAttributes;
    }
  }

  /// get user list notifier
  Stream<List<ZegoUIKitUser>> getUserListStream() {
    return ZegoUIKitCore.shared.coreData.userListStreamCtrl.stream.map(
        (users) => users
            .where((user) => !user.isAnotherRoomUser)
            .map((e) => e.toZegoUikitUser())
            .toList());
  }

  /// get user join notifier
  Stream<List<ZegoUIKitUser>> getUserJoinStream() {
    return ZegoUIKitCore.shared.coreData.userJoinStreamCtrl.stream
        .map((users) => users.map((e) => e.toZegoUikitUser()).toList());
  }

  /// get user leave notifier
  Stream<List<ZegoUIKitUser>> getUserLeaveStream() {
    return ZegoUIKitCore.shared.coreData.userLeaveStreamCtrl.stream
        .map((users) => users.map((e) => e.toZegoUikitUser()).toList());
  }

  /// remove user from room, kick out
  Future<bool> removeUserFromRoom(List<String> userIDs) async {
    return ZegoUIKitCore.shared.removeUserFromRoom(userIDs);
  }

  /// get kicked out notifier
  Stream<String> getMeRemovedFromRoomStream() {
    return ZegoUIKitCore.shared.coreData.meRemovedFromRoomStreamCtrl.stream;
  }
}
