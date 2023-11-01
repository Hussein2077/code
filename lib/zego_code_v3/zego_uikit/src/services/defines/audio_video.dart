// Package imports:

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

/// @nodoc
String get attributeKeyAvatar => 'avatar';

/// @nodoc
class ZegoUIKitReceiveTurnOnLocalMicrophoneEvent {
  final String fromUserID;
  final bool muteMode;

  ZegoUIKitReceiveTurnOnLocalMicrophoneEvent(this.fromUserID, this.muteMode);

  @override
  String toString() {
    return 'from user id:$fromUserID, mute mode:$muteMode';
  }
}

/// @nodoc
enum ZegoUIKitInnerSEIType {
  mixerDeviceState,
  mediaSyncInfo,
}

/// @nodoc
class ZegoUIKitReceiveSEIEvent {
  final String typeIdentifier;
  final String senderID;
  final Map<String, dynamic> sei;

  ZegoUIKitReceiveSEIEvent(this.typeIdentifier, this.senderID, this.sei);
}

/// @nodoc
/// Stream Resource Mode
enum ZegoAudioVideoResourceMode {
  /// Default mode. The SDK will automatically select the streaming resource according to the cdnConfig parameters set by the player config and the ready-made background configuration.
  Default,

  /// Playing stream only from CDN.
  CDNOnly,

  /// Playing stream only from L3.
  L3Only,

  /// Playing stream only from RTC.
  RTCOnly,

  /// CDN Plus mode. The SDK will automatically select the streaming resource according to the network condition.
  CDNPlus,
}

typedef ZegoPresetResolution = ZegoVideoConfigPreset;

/// @nodoc
enum ZegoStreamType {
  main,
  media,
  screenSharing,
  mix,
}

/// @nodoc
extension ZegoStreamTypeExtension on ZegoStreamType {
  String get text {
    switch (this) {
      case ZegoStreamType.main:
      case ZegoStreamType.mix:
        return name;
      case ZegoStreamType.media:
        return 'player';
      case ZegoStreamType.screenSharing:
        return 'screensharing';
    }
  }

  ZegoPublishChannel get channel {
    switch (this) {
      case ZegoStreamType.main:
        return ZegoPublishChannel.Main;
      case ZegoStreamType.media:
      case ZegoStreamType.screenSharing:
      case ZegoStreamType.mix:
        return ZegoPublishChannel.Aux;
    }
  }
}
