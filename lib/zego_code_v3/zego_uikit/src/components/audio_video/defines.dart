// Dart imports:
import 'dart:core';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
/// type of audio video view foreground builder
typedef ZegoAudioVideoViewForegroundBuilder = Widget Function(
  BuildContext context,
  Size size,
  ZegoUIKitUser? user,
  Map<String, dynamic> extraInfo,
);

/// @nodoc
/// type of audio video view background builder
typedef ZegoAudioVideoViewBackgroundBuilder = Widget Function(
  BuildContext context,
  Size size,
  ZegoUIKitUser? user,
  Map<String, dynamic> extraInfo,
);

/// @nodoc
/// sort
typedef ZegoAudioVideoViewSorter = List<ZegoUIKitUser> Function(
    List<ZegoUIKitUser>);

/// @nodoc
/// sort
typedef ZegoAudioVideoViewFilter = List<ZegoUIKitUser> Function(
    List<ZegoUIKitUser>);

/// @nodoc
enum ZegoViewBuilderMapExtraInfoKey {
  isScreenSharingView,
  isFullscreen,
}

/// @nodoc
enum ZegoShowToggleFullscreenButtonMode {
  showWhenScreenPressed,
  alwaysShow,
  alwaysHide,
}

/// @nodoc
extension ZegoViewBuilderMapExtraInfoKeyExtension
    on ZegoViewBuilderMapExtraInfoKey {
  String get text {
    final mapValues = {
      ZegoViewBuilderMapExtraInfoKey.isScreenSharingView:
          'is_screen_sharing_view',
      ZegoViewBuilderMapExtraInfoKey.isFullscreen: 'is_fullscreen',
    };

    return mapValues[this]!;
  }
}
