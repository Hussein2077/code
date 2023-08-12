// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';


// Project imports:

import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/audio_video/avatar/ripple_avatar.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import '../../../../zego_uikit.dart';


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
                color: ColorManager.mainColor,
                //soundLevelColor ?? const Color(0xff6a6b6f),
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
    return ValueListenableBuilder<Map<String, String>>(
      valueListenable:
          user?.inRoomAttributes ?? ValueNotifier<Map<String, String>>({}),
      builder: (context, attributes, _) {
        final avatarURL =
            user?.inRoomAttributes.value[attributeKeyAvatar] ?? '';
        return avatarURL.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: avatarURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) {
                  ZegoLoggerService.logInfo(
                    '${user?.toString()} avatar url is invalid',
                    tag: 'uikit',
                    subTag: 'avatar',
                  );
                  return circleName(context, avatarSize, user);
                },
              )
            : avatarBuilder?.call(
                  context,
                  size,
                  user,
                  extraInfo,
                ) ??
                circleName(context, avatarSize, user);
      },
    );
  }

  Widget circleName(BuildContext context, Size size, ZegoUIKitUser? user) {
    final userName = user?.name ?? '';
    return SizedBox.fromSize(
      size: size,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xffDBDDE3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            userName.isNotEmpty ? userName.characters.first : '',
            style: TextStyle(
              fontSize: showSoundLevel ? size.width / 4 : size.width / 5 * 4,
              color: const Color(0xff222222),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
