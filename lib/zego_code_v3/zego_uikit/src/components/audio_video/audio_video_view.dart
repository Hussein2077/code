// Dart imports:
import 'dart:core';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/avatar/avatar.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/screen_util.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
/// display user audio and video information,
/// and z order of widget(from bottom to top) is:
/// 1. background view
/// 2. video view
/// 3. foreground view
class ZegoAudioVideoView extends StatefulWidget {
  const ZegoAudioVideoView({
    Key? key,
    required this.user,
    this.backgroundBuilder,
    this.foregroundBuilder,
    this.borderRadius,
    this.borderColor,
    this.extraInfo,
    this.avatarConfig,
  }) : super(key: key);

  final ZegoUIKitUser? user;

  /// foreground builder, you can display something you want on top of the view,
  /// foreground will always show
  final ZegoAudioVideoViewForegroundBuilder? foregroundBuilder;

  /// background builder, you can display something when user close camera
  final ZegoAudioVideoViewBackgroundBuilder? backgroundBuilder;

  final double? borderRadius;
  final Color? borderColor;
  final Map<String, dynamic>? extraInfo;

  final ZegoAvatarConfig? avatarConfig;

  @override
  State<ZegoAudioVideoView> createState() => _ZegoAudioVideoViewState();
}

/// @nodoc
class _ZegoAudioVideoViewState extends State<ZegoAudioVideoView> {
  @override
  Widget build(BuildContext context) {
    return circleBorder(
      child: Stack(
        children: [
          background(),
       //todo comment that to remove black container
       //   videoView(),
          foreground(),
        ],
      ),
    );
  }


  Widget background() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: ZegoUIKitUserPropertiesNotifier(
                widget.user ?? ZegoUIKitUser.empty(),
              ),
              builder: (context, _, __) {
                return widget.backgroundBuilder?.call(
                      context,
                      Size(constraints.maxWidth, constraints.maxHeight),
                      widget.user,
                      widget.extraInfo ?? {},
                    ) ??
                    Container(color: Colors.transparent);
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    avatar(constraints.maxWidth, constraints.maxHeight)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget foreground() {
    if (widget.foregroundBuilder != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Stack(children: [
            ValueListenableBuilder(
              valueListenable: ZegoUIKitUserPropertiesNotifier(
                widget.user ?? ZegoUIKitUser.empty(),
              ),
              builder: (context, _, __) {
                return widget.foregroundBuilder!.call(
                  context,
                  Size(constraints.maxWidth, constraints.maxHeight),
                  widget.user,
                  widget.extraInfo ?? {},
                );
              },
            ),
          ]);
        },
      );
    }

    return Container(color: Colors.transparent);
  }

  Widget circleBorder({required Widget child}) {
    if (widget.borderRadius == null) {
      return child;
    }

    final decoration = BoxDecoration(
      border: Border.all(
          color: widget.borderColor ?? const Color(0xffA4A4A4), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius!)),
    );

    return Container(
      decoration: decoration,
      child: PhysicalModel(
        color: widget.borderColor ?? const Color(0xffA4A4A4),
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius!)),
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        shadowColor:
            (widget.borderColor ?? const Color(0xffA4A4A4)).withOpacity(0.3),
        child: child,
      ),
    );
  }


  Widget avatar(double maxWidth, double maxHeight) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallView = maxHeight < screenSize.height / 2;
    final avatarSize =
        isSmallView ? Size(110.zR, 110.zR) : Size(258.zR, 258.zR);

    return Positioned(
      top: getAvatarTop(maxWidth, maxHeight, avatarSize),
      left: (maxWidth - avatarSize.width) / 2,
      child: SizedBox(
        width: widget.avatarConfig?.size?.width ?? avatarSize.width,
        height: widget.avatarConfig?.size?.height ?? avatarSize.width,
        child: ZegoAvatar(
          avatarSize: widget.avatarConfig?.size ?? avatarSize,
          user: widget.user,
          showAvatar: widget.avatarConfig?.showInAudioMode ?? true,
          showSoundLevel:
              widget.avatarConfig?.showSoundWavesInAudioMode ?? true,
          avatarBuilder: widget.avatarConfig?.builder,
          soundLevelSize: widget.avatarConfig?.size,
          soundLevelColor: widget.avatarConfig?.soundWaveColor,
        ),
      ),
    );
  }

  double getAvatarTop(double maxWidth, double maxHeight, Size avatarSize) {
    switch (
        widget.avatarConfig?.verticalAlignment ?? ZegoAvatarAlignment.center) {
      case ZegoAvatarAlignment.center:
        return (maxHeight - avatarSize.height) / 2;
      case ZegoAvatarAlignment.start:
        return 15.zR; //  sound level height
      case ZegoAvatarAlignment.end:
        return maxHeight - avatarSize.height;
    }
  }
}
