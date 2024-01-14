
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/audio.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/room.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

/// @nodoc
const streamExtraInfoMicrophoneKey = 'isMicrophoneOn';

/// @nodoc
const streamSEIKeyMicrophone = 'mic';

/// @nodoc
const streamSEIKeySEI = 'sei';

/// @nodoc
const streamSEIKeyTypeIdentifier = 'type';

/// @nodoc
const streamSEIKeyUserID = 'uid';

/// @nodoc
const streamSEIKeyMediaStatus = 'md_stat';

/// @nodoc
const streamSEIKeyMediaProgress = 'md_pro';

/// @nodoc
const streamSEIKeyMediaDuration = 'md_dur';

/// @nodoc
const streamSEIKeyMediaType = 'md_type';

/// @nodoc
const streamSEIKeyMediaSoundLevel = 'md_s_l';

/// @nodoc
class ZegoUIKitCoreMixerStream {
  final String streamID;
  int viewID = -1;
  ValueNotifier<Widget?> view = ValueNotifier<Widget?>(null);
  ValueNotifier<bool> loaded = ValueNotifier<bool>(false); // first frame

  List<ZegoUIKitCoreUser> users = [];

  ZegoUIKitCoreMixerStream(this.streamID, this.users);

  void destroyTextureRenderer({bool isMainStream = true}) {
    if (viewID != -1) {
      ZegoExpressEngine.instance.destroyCanvasView(viewID);
    }
    viewID = -1;
    view.value = null;
  }
}

/// @nodoc
typedef ZegoUIKitUserAttributes = Map<String, String>;

/// @nodoc
extension ZegoUIKitUserAttributesExtension on ZegoUIKitUserAttributes {
  String get avatarURL {
    return this[attributeKeyAvatar] ?? '';
  }
}

class ZegoUIKitCoreStreamInfo {
  String streamID = '';
  int streamTimestamp = 0;

  int viewID = -1;
  ValueNotifier<Widget?> view = ValueNotifier<Widget?>(null);
  ValueNotifier<Size> viewSize = ValueNotifier<Size>(const Size(360, 640));
  StreamController<double> soundLevel = StreamController<double>.broadcast();

  ZegoUIKitCoreStreamInfo.empty();
}

/// @nodoc
// user
class ZegoUIKitCoreUser {
  ZegoUIKitCoreUser(this.id, this.name);

  ZegoUIKitCoreUser.fromZego(ZegoUser user) : this(user.userID, user.userName);

  ZegoUIKitCoreUser.empty();

  ZegoUIKitCoreUser.localDefault() {
    microphone.value = true;
  }

  String id = '';
  String name = '';

  ValueNotifier<bool> microphone = ValueNotifier<bool>(false);
  ValueNotifier<bool> microphoneMuteMode = ValueNotifier<bool>(false);

  ValueNotifier<ZegoUIKitUserAttributes> inRoomAttributes =
      ValueNotifier<ZegoUIKitUserAttributes>({});

  ZegoUIKitCoreStreamInfo mainChannel = ZegoUIKitCoreStreamInfo.empty();
  ZegoUIKitCoreStreamInfo auxChannel = ZegoUIKitCoreStreamInfo.empty();
  ZegoUIKitCoreStreamInfo thirdChannel = ZegoUIKitCoreStreamInfo.empty();

  bool isAnotherRoomUser = false;

  void destroyTextureRenderer({required ZegoStreamType streamType}) {
    switch (streamType) {
      case ZegoStreamType.main:
        if (mainChannel.viewID != -1) {
          ZegoExpressEngine.instance.destroyCanvasView(mainChannel.viewID);
        }

        mainChannel.viewID = -1;
        mainChannel.view.value = null;
        mainChannel.viewSize.value = const Size(360, 640);
        break;
      case ZegoStreamType.media:
      case ZegoStreamType.screenSharing:
      case ZegoStreamType.mix:
        if (auxChannel.viewID != -1) {
          ZegoExpressEngine.instance.destroyCanvasView(auxChannel.viewID);
        }

        auxChannel.viewID = -1;
        auxChannel.view.value = null;
        auxChannel.viewSize.value = const Size(360, 640);
        break;
    }
  }

  ValueNotifier<ZegoStreamQualityLevel> network =
      ValueNotifier<ZegoStreamQualityLevel>(ZegoStreamQualityLevel.Excellent);

  // only for local
  ValueNotifier<bool> isFrontFacing = ValueNotifier<bool>(true);
  ValueNotifier<bool> isVideoMirror = ValueNotifier<bool>(false);
  ValueNotifier<ZegoAudioRoute> audioRoute =
      ValueNotifier<ZegoAudioRoute>(ZegoAudioRoute.Receiver);
  ZegoAudioRoute lastAudioRoute = ZegoAudioRoute.Receiver;

  ZegoUIKitUser toZegoUikitUser() => ZegoUIKitUser(id: id, name: name);

  ZegoUser toZegoUser() => ZegoUser(id, name);

  @override
  String toString() {
    return 'id:$id, name:$name';
  }
}

/// @nodoc
String generateStreamID(String userID, String roomID, ZegoStreamType type) {
  return '${roomID}_${userID}_${type.text}';
}

/// @nodoc
// room
class ZegoUIKitCoreRoom {
  ZegoUIKitCoreRoom(this.id) {
    ZegoLoggerService.logInfo(
      'create $id',
      tag: 'uikit',
      subTag: 'core room',
    );
  }

  String id = '';

  bool isLargeRoom = false;
  bool markAsLargeRoom = false;

  ValueNotifier<ZegoUIKitRoomState> state = ValueNotifier<ZegoUIKitRoomState>(
      ZegoUIKitRoomState(ZegoRoomStateChangedReason.Logout, 0, {}));

  bool roomExtraInfoHadArrived = false;
  Map<String, RoomProperty> properties = {};
  bool propertiesAPIRequesting = false;
  Map<String, String> pendingProperties = {};

  StreamController<RoomProperty> propertyUpdateStream =
      StreamController<RoomProperty>.broadcast();
  StreamController<Map<String, RoomProperty>> propertiesUpdatedStream =
      StreamController<Map<String, RoomProperty>>.broadcast();

  void clear() {
    id = '';

    properties.clear();
    propertiesAPIRequesting = false;
    pendingProperties.clear();
  }

  ZegoUIKitRoom toUIKitRoom() {
    return ZegoUIKitRoom(id: id);
  }
}

/// @nodoc
// video config
class ZegoUIKitVideoConfig {
  ZegoUIKitVideoConfig({
    this.resolution = ZegoPresetResolution.Preset360P,
    this.orientation = DeviceOrientation.portraitUp,
    this.useVideoViewAspectFill = false,
  });

  ZegoPresetResolution resolution;
  DeviceOrientation orientation;
  bool useVideoViewAspectFill;

  bool needUpdateOrientation(ZegoUIKitVideoConfig newConfig) {
    return orientation != newConfig.orientation;
  }

  bool needUpdateVideoConfig(ZegoUIKitVideoConfig newConfig) {
    return (resolution != newConfig.resolution) ||
        (orientation != newConfig.orientation);
  }

  ZegoVideoConfig toZegoVideoConfig() {
    final config = ZegoVideoConfig.preset(resolution);
    if (orientation == DeviceOrientation.landscapeLeft ||
        orientation == DeviceOrientation.landscapeRight) {
      var tmp = config.captureHeight;
      config
        ..captureHeight = config.captureWidth
        ..captureWidth = tmp;

      tmp = config.encodeHeight;
      config
        ..encodeHeight = config.encodeWidth
        ..encodeWidth = tmp;
    }
    return config;
  }

  ZegoUIKitVideoConfig copyWith({
    ZegoPresetResolution? resolution,
    DeviceOrientation? orientation,
    bool? useVideoViewAspectFill,
  }) =>
      ZegoUIKitVideoConfig(
        resolution: resolution ?? this.resolution,
        orientation: orientation ?? this.orientation,
        useVideoViewAspectFill:
            useVideoViewAspectFill ?? this.useVideoViewAspectFill,
      );
}

/// @nodoc
class ZegoUIKitAdvancedConfigKey {
  static const String videoViewMode = 'videoViewMode';
}
