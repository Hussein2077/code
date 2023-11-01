// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

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
