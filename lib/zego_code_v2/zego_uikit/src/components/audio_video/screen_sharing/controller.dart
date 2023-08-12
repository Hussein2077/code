// Flutter imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';
import 'package:flutter/cupertino.dart';

// Project imports:

/// @nodoc
class ZegoScreenSharingViewController {
  final _fullscreenUserNotifier = ValueNotifier<ZegoUIKitUser?>(null);

  ValueNotifier<ZegoUIKitUser?> get fullscreenUserNotifier =>
      _fullscreenUserNotifier;

  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen) {
    _fullscreenUserNotifier.value =
        isFullscreen ? ZegoUIKit().getUser(userID) : null;
  }
}
