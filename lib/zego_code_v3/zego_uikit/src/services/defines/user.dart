// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/defines.dart';

// Package imports:
import 'package:zego_express_engine/zego_express_engine.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';

/// @nodoc
class ZegoUIKitUser {
  String id = '';
  String name = '';

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory ZegoUIKitUser.fromJson(Map<String, dynamic> json) {
    return ZegoUIKitUser(
      id: json['id'],
      name: json['name'],
    );
  }

  ValueNotifier<bool> get microphone {
    return ZegoUIKitCore.shared.coreData.getUser(id).microphone;
  }

  ValueNotifier<bool> get microphoneMuteMode {
    return ZegoUIKitCore.shared.coreData.getUser(id).microphoneMuteMode;
  }

  ValueNotifier<bool> get camera {
    return ZegoUIKitCore.shared.coreData.getUser(id).camera;
  }

  ValueNotifier<bool> get cameraMuteMode {
    return ZegoUIKitCore.shared.coreData.getUser(id).cameraMuteMode;
  }

  Stream<double> get soundLevel {
    return ZegoUIKitCore.shared.coreData
        .getUser(id)
        .mainChannel
        .soundLevel
        .stream;
  }

  Stream<double> get auxSoundLevel {
    return ZegoUIKitCore.shared.coreData
        .getUser(id)
        .auxChannel
        .soundLevel
        .stream;
  }

  ValueNotifier<ZegoUIKitUserAttributes> get inRoomAttributes {
    return ZegoUIKitCore.shared.coreData.getUser(id).inRoomAttributes;
  }

  String get streamID {
    return ZegoUIKitCore.shared.coreData.getUser(id).mainChannel.streamID;
  }

  int get streamTimestamp {
    return ZegoUIKitCore.shared.coreData
        .getUser(id)
        .mainChannel
        .streamTimestamp;
  }

  ZegoUIKitUser.empty();

  bool isEmpty() {
    return id.isEmpty || name.isEmpty;
  }

  ZegoUIKitUser({
    required this.id,
    required this.name,
  });

  // internal helper function
  ZegoUser toZegoUser() => ZegoUser(id, name);

  ZegoUIKitUser.fromZego(ZegoUser zegoUser)
      : this(id: zegoUser.userID, name: zegoUser.userName);

  @override
  String toString() {
    return '{id:$id, name:$name, in-room attributes:${inRoomAttributes.value}, '
        'camera:${camera.value}, microphone:${microphone.value}, '
        'microphone mute mode:${microphoneMuteMode.value} }';
  }
}

/// @nodoc
class ZegoUIKitUserPropertiesNotifier extends ChangeNotifier
    implements ValueListenable<int> {
  int _updateTimestamp = 0;
  final ZegoUIKitUser _user;
  late ZegoUIKitCoreUser _coreUser;

  ZegoUIKitUserPropertiesNotifier(ZegoUIKitUser user) : _user = user {
    _coreUser = ZegoUIKitCore.shared.coreData.getUser(_user.id);
    listenUserProperty();
  }

  ZegoUIKitUser get user => _user;

  void listenUserProperty() {
    _coreUser.camera.addListener(onCameraStatusChanged);
    _coreUser.cameraMuteMode.addListener(onCameraMuteModeChanged);

    _coreUser.microphone.addListener(onMicrophoneStatusChanged);
    _coreUser.microphoneMuteMode.addListener(onMicrophoneMuteModeChanged);

    _coreUser.inRoomAttributes.addListener(onInRoomAttributesUpdated);
  }

  void removeListenUserProperty() {
    _coreUser.camera.removeListener(onCameraStatusChanged);
    _coreUser.cameraMuteMode.removeListener(onCameraMuteModeChanged);

    _coreUser.microphone.removeListener(onMicrophoneStatusChanged);
    _coreUser.microphoneMuteMode.removeListener(onMicrophoneMuteModeChanged);

    _coreUser.inRoomAttributes.removeListener(onInRoomAttributesUpdated);
  }

  void onCameraStatusChanged() {
    _updateTimestamp = DateTime.now().microsecondsSinceEpoch;

    notifyListeners();
  }

  void onCameraMuteModeChanged() {
    _updateTimestamp = DateTime.now().microsecondsSinceEpoch;

    notifyListeners();
  }

  void onMicrophoneStatusChanged() {
    _updateTimestamp = DateTime.now().microsecondsSinceEpoch;

    notifyListeners();
  }

  void onMicrophoneMuteModeChanged() {
    _updateTimestamp = DateTime.now().microsecondsSinceEpoch;

    notifyListeners();
  }

  void onInRoomAttributesUpdated() {
    _updateTimestamp = DateTime.now().microsecondsSinceEpoch;

    notifyListeners();
  }

  @override
  int get value => _updateTimestamp;
}
