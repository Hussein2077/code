// Dart imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/audio_video.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
/// container of media,
class ZegoMediaContainer extends StatefulWidget {
  const ZegoMediaContainer({
    Key? key,
    this.foregroundBuilder,
    this.backgroundBuilder,
  }) : super(key: key);

  /// foreground builder of audio video view
  final ZegoAudioVideoViewForegroundBuilder? foregroundBuilder;

  /// background builder of audio video view
  final ZegoAudioVideoViewBackgroundBuilder? backgroundBuilder;

  @override
  State<ZegoMediaContainer> createState() => _ZegoMediaContainerState();
}

/// @nodoc
class _ZegoMediaContainerState extends State<ZegoMediaContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ZegoUIKitUser>>(
      stream: ZegoUIKit().getMediaListStream(),
      builder: (context, snapshot) {
        final mediaUsers = ZegoUIKit().getMediaList();
        if (mediaUsers.isEmpty) {
          return Container();
        }

        return ZegoMediaView(
          user: mediaUsers.first,
          backgroundBuilder: widget.backgroundBuilder,
          foregroundBuilder: widget.foregroundBuilder,
        );
      },
    );
  }
}
