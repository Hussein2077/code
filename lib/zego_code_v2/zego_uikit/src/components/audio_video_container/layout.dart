// Flutter imports:
import 'package:flutter/material.dart';


// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/audio_video_container/layout_gallery.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/audio_video_container/layout_picture_in_picture.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/audio_video_container/picture_in_picture/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/defines.dart';

/// layout config
/// 1. picture in picture
/// 2. gallery
class ZegoLayout {
  const ZegoLayout.internal();

  factory ZegoLayout.pictureInPicture({
    /// small video view is draggable if set true
    bool isSmallViewDraggable = true,

    ///  Whether you can switch view's position by clicking on the small view
    bool switchLargeOrSmallViewByClick = true,

    /// whether to hide the local View when the local camera is closed
    ZegoViewPosition smallViewPosition = ZegoViewPosition.topRight,
    EdgeInsets? smallViewMargin,

    ///
    Size? smallViewSize,

    ///
    EdgeInsets? spacingBetweenSmallViews,
    bool showNewScreenSharingViewInFullscreenMode = true,
    ZegoShowFullscreenModeToggleButtonRules showScreenSharingFullscreenModeToggleButtonRules =
        ZegoShowFullscreenModeToggleButtonRules.showWhenScreenPressed,
  }) {
    return ZegoLayoutPictureInPictureConfig(
        isSmallViewDraggable: isSmallViewDraggable,
        switchLargeOrSmallViewByClick: switchLargeOrSmallViewByClick,
        smallViewPosition: smallViewPosition,
        smallViewSize: smallViewSize,
        smallViewMargin: smallViewMargin,
        spacingBetweenSmallViews: spacingBetweenSmallViews,
        showNewScreenSharingViewInFullscreenMode:
            showNewScreenSharingViewInFullscreenMode,
        showScreenSharingFullscreenModeToggleButtonRules:
            showScreenSharingFullscreenModeToggleButtonRules);
  }

  factory ZegoLayout.gallery(
      {
      /// whether to display rounded corners and spacing between views
      bool addBorderRadiusAndSpacingBetweenView = true,
      bool showNewScreenSharingViewInFullscreenMode = true,
      ZegoShowFullscreenModeToggleButtonRules showScreenSharingFullscreenModeToggleButtonRules =
          ZegoShowFullscreenModeToggleButtonRules.showWhenScreenPressed}) {
    return ZegoLayoutGalleryConfig(
        addBorderRadiusAndSpacingBetweenView:
            addBorderRadiusAndSpacingBetweenView,
        showNewScreenSharingViewInFullscreenMode:
            showNewScreenSharingViewInFullscreenMode,
        showScreenSharingFullscreenModeToggleButtonRules:
            showScreenSharingFullscreenModeToggleButtonRules);
  }
}
