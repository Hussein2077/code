// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:


import '../../../zego_uikit.dart';

class ZegoScreenSharingViewController {
  final _fullscreenUserNotifier = ValueNotifier<ZegoUIKitUser?>(null);

  ValueNotifier<ZegoUIKitUser?> get fullscreenUserNotifier =>
      _fullscreenUserNotifier;

  void showScreenSharingViewInFullscreenMode(String userID, bool isFullscreen) {
    _fullscreenUserNotifier.value =
        isFullscreen ? ZegoUIKit().getUser(userID) : null;
  }
}
