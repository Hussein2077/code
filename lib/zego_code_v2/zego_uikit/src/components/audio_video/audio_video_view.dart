// Dart imports:
import 'dart:core';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';


// Project imports:
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/audio_video/avatar/avatar.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/internal/internal.dart';
import '../../services/services.dart';
import '../defines.dart';

/// display user audio and video information,
/// and z order of widget(from bottom to top) is:
/// 1. background view
/// 2. video view
/// 3. foreground view
class ZegoAudioVideoView extends StatefulWidget {
  const ZegoAudioVideoView({
    Key? key,
    required this.user,
     this.isMicrophoneEnabled,
     this.roomMode,
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
  final LayoutMode? roomMode ;
  final bool? isMicrophoneEnabled ;

  final ZegoAvatarConfig? avatarConfig;

  @override
  State<ZegoAudioVideoView> createState() => _ZegoAudioVideoViewState();
}

class _ZegoAudioVideoViewState extends State<ZegoAudioVideoView> {
  @override
  Widget build(BuildContext context) {
    return circleBorder(
      child: Stack(
        children: [
          background(),
       //   videoView(),
          foreground(),
        ],
      ),
    );
  }

  Widget videoView() {
    if (widget.user == null) {
      return Container(color: Colors.transparent);
    }

    return ValueListenableBuilder<bool>(
      valueListenable: ZegoUIKit().getCameraStateNotifier(widget.user!.id),
      builder: (context, isCameraOn, _) {
        if (!isCameraOn) {
          /// hide video view when use close camera
          return Container(color: Colors.transparent);
        }

        return SizedBox.expand(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ValueListenableBuilder<Widget?>(
                valueListenable:
                    ZegoUIKit().getAudioVideoViewNotifier(widget.user!.id),
                builder: (context, userView, _) {
                  if (userView == null) {
                    /// hide video view when use not found
                    return Container(color: Colors.transparent);
                  }

                  return StreamBuilder(
                    stream: NativeDeviceOrientationCommunicator()
                        .onOrientationChanged(),
                    builder: (context,
                        AsyncSnapshot<NativeDeviceOrientation> asyncResult) {
                      if (asyncResult.hasData) {
                        /// Do not update ui when ui is building !!!
                        /// use postFrameCallback to update videoSize
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ///  notify sdk to update video render orientation
                          ZegoUIKit().updateAppOrientation(
                            deviceOrientationMap(asyncResult.data!),
                          );
                        });
                      }
                      return userView;
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget background() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            widget.backgroundBuilder?.call(
                  context,
                  Size(constraints.maxWidth, constraints.maxHeight),
                  widget.user,
                  widget.extraInfo ?? {},
                ) ??
                Container(color: Colors.transparent),
          //  if(widget.isMicrophoneEnabled??true) // to show image avater when mic is mute
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
            widget.foregroundBuilder!.call(
              context,
              Size(constraints.maxWidth, constraints.maxHeight),
              widget.user,
              widget.extraInfo ?? {},
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
    final avatarSize = isSmallView ? Size(110.r, 110.r) : Size(258.r, 258.r);

    return Positioned(
      top: widget.roomMode == null ?  40.h : widget.roomMode == LayoutMode.hostTopCenter ?   40.h  : 30.h,
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
        return 15.r; //  sound level height
      case ZegoAvatarAlignment.end:
        return maxHeight - avatarSize.height;
    }
  }
}
