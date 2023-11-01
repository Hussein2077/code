// Dart imports:
import 'dart:async';

// Flutter imports:


// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/internal.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

mixin ZegoUIKitCoreDataUser {
  ZegoUIKitCoreUser localUser = ZegoUIKitCoreUser.localDefault();

  final List<ZegoUIKitCoreUser> remoteUsersList = [];

  StreamController<List<ZegoUIKitCoreUser>> userJoinStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();
  StreamController<List<ZegoUIKitCoreUser>> userLeaveStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();
  StreamController<List<ZegoUIKitCoreUser>> userListStreamCtrl =
      StreamController<List<ZegoUIKitCoreUser>>.broadcast();

  StreamController<String> meRemovedFromRoomStreamCtrl =
      StreamController<String>.broadcast();

  ZegoUIKitCoreUser getUser(String userID) {
    if (userID == localUser.id) {
      return localUser;
    } else {
      return remoteUsersList.firstWhere((user) => user.id == userID,
          orElse: ZegoUIKitCoreUser.empty);
    }
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

    if (localUser.id == id && localUser.name == name) {
      ZegoLoggerService.logError(
        'login user is same',
        tag: 'uikit',
        subTag: 'core data',
      );

      return localUser;
    }

    if ((localUser.id.isNotEmpty && localUser.id != id) ||
        (localUser.name.isNotEmpty && localUser.name != name)) {
      ZegoLoggerService.logError(
        'login exist before, and not same, auto logout...',
        tag: 'uikit',
        subTag: 'core data',
      );
      logout();
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

  ZegoUIKitCoreUser removeUser(String uid) {
    final targetIndex = remoteUsersList.indexWhere((user) => uid == user.id);
    if (-1 == targetIndex) {
      return ZegoUIKitCoreUser.empty();
    }

    final targetUser = remoteUsersList.removeAt(targetIndex);
    if (targetUser.mainChannel.streamID.isNotEmpty) {
      ZegoUIKitCore.shared.coreData
          .stopPlayingStream(targetUser.mainChannel.streamID);
    }
    if (targetUser.auxChannel.streamID.isNotEmpty) {
      ZegoUIKitCore.shared.coreData
          .stopPlayingStream(targetUser.auxChannel.streamID);
    }
    if (targetUser.thirdChannel.streamID.isNotEmpty) {
      ZegoUIKitCore.shared.coreData
          .stopPlayingStream(targetUser.thirdChannel.streamID);
    }

    if (ZegoUIKitCore.shared.coreData.mediaOwnerID == uid) {
      ZegoUIKitCore.shared.coreData.clearMedia();
    }

    return targetUser;
  }
}
