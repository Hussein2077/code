// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

/// @nodoc
enum MediaType {
  PureAudio,
  Video,
  Unknown,
}

/// @nodoc
class MediaPlayResult {
  int errorCode;

  MediaPlayResult({required this.errorCode});
}

/// @nodoc
class MediaSeekToResult {
  int errorCode;

  MediaSeekToResult({required this.errorCode});
}

/// @nodoc
enum MediaPlayState {
  /// Not playing
  NoPlay,

  /// Playing
  Playing,

  /// Pausing
  Pausing,

  /// End of play
  PlayEnded
}

/// @nodoc
/// Media Infomration of media file.
///
/// Meida information such as video resolution of media file.
class MediaInfo {
  /// Video resolution width.
  int width;

  /// Video resolution height.
  int height;

  /// Video frame rate.
  int frameRate;

  MediaInfo({
    required this.width,
    required this.height,
    required this.frameRate,
  });

  /// Constructs a media player information object by default.
  MediaInfo.defaultInfo()
      : width = 0,
        height = 0,
        frameRate = 0;

  MediaInfo.fromZego(ZegoMediaPlayerMediaInfo? zegoMediaInfo)
      : this(
          width: zegoMediaInfo?.width ?? 0,
          height: zegoMediaInfo?.height ?? 0,
          frameRate: zegoMediaInfo?.frameRate ?? 0,
        );
}
