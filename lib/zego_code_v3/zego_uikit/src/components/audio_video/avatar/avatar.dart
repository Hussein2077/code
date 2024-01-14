// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/avatar/ripple_avatar.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

/// @nodoc
class ZegoAvatar extends StatelessWidget {
  final Size avatarSize;
  final ZegoUIKitUser? user;
  final bool showAvatar;
  final bool showSoundLevel;
  final Size? soundLevelSize;
  final Color? soundLevelColor;
  final ZegoAvatarBuilder? avatarBuilder;

  const ZegoAvatar({
    Key? key,
    required this.avatarSize,
    this.user,
    this.showAvatar = true,
    this.showSoundLevel = false,
    this.soundLevelSize,
    this.soundLevelColor,
    this.avatarBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showAvatar || user == null) {
      return Container(color: Colors.transparent);
    }

    final centralAvatar = avatarBuilderWithURL(context, avatarSize, user, {});
    return Center(
      child: SizedBox.fromSize(
        size: showSoundLevel ? soundLevelSize : avatarSize,
        child: showSoundLevel
            ? ZegoRippleAvatar(
                user: user,
                color: soundLevelColor ?? const Color(0xff6a6b6f),
                minRadius: min(avatarSize.width, avatarSize.height) / 2,
                radiusIncrement: 0.06,
                child: centralAvatar,
              )
            : centralAvatar,
      ),
    );
  }

  Widget avatarBuilderWithURL(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    return ValueListenableBuilder(
      valueListenable: ZegoUIKitUserPropertiesNotifier(
        user ?? ZegoUIKitUser.empty(),
      ),
      builder: (context, _, __) {
        return avatarBuilder?.call(
              context,
              size,
              user,
              extraInfo,
            ) ??const SizedBox();
      },
    );
  }

}
