// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';

/// @nodoc
const controlBarButtonBackgroundColor = Colors.white;

/// @nodoc
final controlBarButtonCheckedBackgroundColor =
    const Color(0xff2C2F3E).withOpacity(0.6);

/// @nodoc
class UIKitImage {
  static Image asset(
    String name, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      name,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

/// @nodoc
class StyleIconUrls {





















  static const String iconSend = AssetsPath.sendMessage;
  static const String iconSendDisable = AssetsPath.sendMessage;





  static const String messageLoading = AssetsPath.loadingGif;
  static const String messageFail = AssetsPath.netError;

  static const String iconScreenShareStart =
      'assets/icons/share_screen_start.png';
  static const String iconScreenShareStop =
      'assets/icons/share_screen_stop.png';

  static const String iconVideoViewFullScreenClose =
      'assets/icons/video_view_full_screen_close.png';
  static const String iconVideoViewFullScreenOpen =
      'assets/icons/video_view_full_screen_open.png';
}
