// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/audio_video.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video_container/layout.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video_container/layout_gallery.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video_container/layout_picture_in_picture.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
enum AudioVideoViewFullScreeMode {
  none,
  normal,
  autoOrientation,
}

/// @nodoc
/// container of audio video view,
/// it will layout views by layout mode and config
class ZegoAudioVideoContainer extends StatefulWidget {
  const ZegoAudioVideoContainer({
    Key? key,
    required this.layout,
    this.foregroundBuilder,
    this.backgroundBuilder,
    this.sortAudioVideo,
    this.filterAudioVideo,
    this.avatarConfig,
    this.screenSharingViewController,
  }) : super(key: key);

  final ZegoLayout layout;

  /// foreground builder of audio video view
  final ZegoAudioVideoViewForegroundBuilder? foregroundBuilder;

  /// background builder of audio video view
  final ZegoAudioVideoViewBackgroundBuilder? backgroundBuilder;

  /// sorter
  final ZegoAudioVideoViewSorter? sortAudioVideo;

  /// filter
  final ZegoAudioVideoViewFilter? filterAudioVideo;

  /// avatar etc.
  final ZegoAvatarConfig? avatarConfig;

  final ZegoScreenSharingViewController? screenSharingViewController;

  @override
  State<ZegoAudioVideoContainer> createState() =>
      _ZegoAudioVideoContainerState();
}

/// @nodoc
class _ZegoAudioVideoContainerState extends State<ZegoAudioVideoContainer> {
  List<ZegoUIKitUser> userList = [];
  List<StreamSubscription<dynamic>?> subscriptions = [];

  var defaultScreenSharingViewController = ZegoScreenSharingViewController();

  ValueNotifier<ZegoUIKitUser?> get fullScreenUserNotifier =>
      widget.screenSharingViewController?.fullscreenUserNotifier ??
      defaultScreenSharingViewController.fullscreenUserNotifier;

  @override
  void initState() {
    super.initState();

    if (ZegoUIKit().getScreenSharingList().isNotEmpty) {
      fullScreenUserNotifier.value = ZegoUIKit().getScreenSharingList().first;
    }

    subscriptions
      ..add(ZegoUIKit().getAudioVideoListStream().listen(onStreamListUpdated))
      ..add(
          ZegoUIKit().getScreenSharingListStream().listen(onStreamListUpdated));
  }

  @override
  void dispose() {
    super.dispose();

    for (final subscription in subscriptions) {
      subscription?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ZegoUIKitUser?>(
        valueListenable: fullScreenUserNotifier,
        builder: (BuildContext context, fullscreenUser, _) {
          if (fullscreenUser != null &&
              (widget.layout is ZegoLayoutGalleryConfig) &&
              (widget.layout as ZegoLayoutGalleryConfig)
                  .showNewScreenSharingViewInFullscreenMode) {
            return ZegoScreenSharingView(
              user: fullscreenUser,
              foregroundBuilder: widget.foregroundBuilder,
              backgroundBuilder: widget.backgroundBuilder,
              controller: widget.screenSharingViewController ??
                  defaultScreenSharingViewController,
              showFullscreenModeToggleButtonRules:
                  (widget.layout is ZegoLayoutGalleryConfig)
                      ? (widget.layout as ZegoLayoutGalleryConfig)
                          .showScreenSharingFullscreenModeToggleButtonRules
                      : ZegoShowFullscreenModeToggleButtonRules
                          .showWhenScreenPressed,
            );
          } else {
            updateUserList(ZegoUIKit().getAudioVideoList() +
                ZegoUIKit().getScreenSharingList());
            return StreamBuilder<List<ZegoUIKitUser>>(
              stream: ZegoUIKit().getAudioVideoListStream(),
              builder: (context, snapshot) {
                if (widget.layout is ZegoLayoutPictureInPictureConfig) {
                  return pictureInPictureLayout(userList);
                } else if (widget.layout is ZegoLayoutGalleryConfig) {
                  return galleryLayout(userList);
                }
                assert(false, 'Unimplemented layout');
                return Container();
              },
            );
          }
        });
  }

  /// picture in picture
  Widget pictureInPictureLayout(List<ZegoUIKitUser> userList) {
    return ZegoLayoutPictureInPicture(
      layoutConfig: widget.layout as ZegoLayoutPictureInPictureConfig,
      backgroundBuilder: widget.backgroundBuilder,
      foregroundBuilder: widget.foregroundBuilder,
      userList: userList,
      avatarConfig: widget.avatarConfig,
    );
  }

  /// gallery
  Widget galleryLayout(List<ZegoUIKitUser> userList) {
    return ZegoLayoutGallery(
      layoutConfig: widget.layout as ZegoLayoutGalleryConfig,
      backgroundBuilder: widget.backgroundBuilder,
      foregroundBuilder: widget.foregroundBuilder,
      userList: userList,
      maxItemCount: 8,
      avatarConfig: widget.avatarConfig,
      screenSharingViewController: widget.screenSharingViewController ??
          defaultScreenSharingViewController,
    );
  }

  void onStreamListUpdated(List<ZegoUIKitUser> streamUsers) {
    fullScreenUserNotifier.value = ZegoUIKit().getScreenSharingList().isEmpty
        ? null
        : ZegoUIKit().getScreenSharingList().first;

    setState(() {
      updateUserList(
        ZegoUIKit().getAudioVideoList() + ZegoUIKit().getScreenSharingList(),
      );
    });

    // if ((widget.layout is ZegoLayoutGalleryConfig) &&
    //     ZegoUIKit().getScreenSharingList().isNotEmpty) {
    //   if ((widget.layout as ZegoLayoutGalleryConfig)
    //       .showNewScreenSharingViewInFullscreenMode) {
    //     //default full share screen
    //     fullScreenUserNotifier.value =
    //         ZegoUIKit().getScreenSharingList().first;
    //   } else {
    //     fullScreenUserNotifier.value = null;
    //   }
    // } else {
    //   fullScreenUserNotifier.value = null;
    // }
  }

  void updateUserList(List<ZegoUIKitUser> streamUsers) {
    /// remove if not in stream
    userList.removeWhere((user) =>
        -1 == streamUsers.indexWhere((streamUser) => user.id == streamUser.id));

    /// add if stream added
    for (final streamUser in streamUsers) {
      if (-1 == userList.indexWhere((user) => user.id == streamUser.id)) {
        userList.add(streamUser);
      }
    }

    userList =
        widget.sortAudioVideo?.call(List<ZegoUIKitUser>.from(userList)) ??
            userList;

    userList =
        widget.filterAudioVideo?.call(List<ZegoUIKitUser>.from(userList)) ??
            userList;
  }
}
