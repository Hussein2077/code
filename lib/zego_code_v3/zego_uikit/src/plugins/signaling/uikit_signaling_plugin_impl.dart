// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/background_message_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/callkit_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/message_service.dart';

// Project imports:
import '../../../zego_uikit.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/core/core.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/invitation_plugin_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/notification_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/room_properties.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/signaling/impl/service/user_attributes.dart';
export 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

/// @nodoc
class ZegoUIKitSignalingPluginImpl
    with
        ZegoPluginInvitationService,
        ZegoPluginNotificationService,
        ZegoUIKitMessagesPluginService,
        ZegoUIKitRoomAttributesPluginService,
        ZegoUIKitUserInRoomAttributesPluginService,
        ZegoPluginBackgroundMessageService,
        ZegoPluginCallKitService {
  factory ZegoUIKitSignalingPluginImpl() => shared;

  ZegoUIKitSignalingPluginImpl._internal() {
    WidgetsFlutterBinding.ensureInitialized();
    assert(
        ZegoPluginAdapter().signalingPlugin != null,
        'ZegoUIKitSignalingPluginImpl: ZegoUIKitPluginType.signaling is null, '
        'plugins should contain ZegoUIKitSignalingPlugin');
  }

  static final ZegoUIKitSignalingPluginImpl shared =
      ZegoUIKitSignalingPluginImpl._internal();

  bool isInit() {
    return ZegoSignalingPluginCore.shared.isInit();
  }

  /// init
  Future<void> init(
    int appID, {
    String appSign = '',
  }) async {
    initUserInRoomAttributes();
    return ZegoSignalingPluginCore.shared.init(appID: appID, appSign: appSign);
  }

  /// uninit
  Future<void> uninit({bool forceDestroy = false}) async {
    uninitUserInRoomAttributes();

    return ZegoSignalingPluginCore.shared.uninit(forceDestroy: forceDestroy);
  }

  /// Call this function when you [didReceiveIncomingPush] to active audio in callkit mode
  Future<void> activeAudioByCallKit() async {
    return ZegoSignalingPluginCore.shared.activeAudioByCallKit();
  }

  /// login
  Future<bool> login({
    required String id,
    required String name,
  }) async {
    return ZegoSignalingPluginCore.shared.login(id, name);
  }

  /// logout
  Future<void> logout() async {
    return ZegoSignalingPluginCore.shared.logout();
  }

  /// join room
  Future<ZegoSignalingPluginJoinRoomResult> joinRoom(String roomID,
      {String roomName = ''}) async {
    return ZegoSignalingPluginCore.shared.joinRoom(roomID, roomName);
  }

  String getRoomID() {
    return ZegoSignalingPluginCore.shared.getRoomID();
  }

  /// leave room
  Future<void> leaveRoom() async {
    return ZegoSignalingPluginCore.shared.leaveRoom();
  }

  ZegoSignalingPluginConnectionState getConnectionState() {
    return ZegoPluginAdapter().signalingPlugin!.getConnectionState();
  }

  Stream<ZegoSignalingPluginConnectionStateChangedEvent>
      getConnectionStateStream() {
    return ZegoPluginAdapter()
        .signalingPlugin!
        .getConnectionStateChangedEventStream();
  }

  ZegoSignalingPluginRoomState getRoomState() {
    return ZegoPluginAdapter().signalingPlugin!.getRoomState();
  }

  Stream<ZegoSignalingPluginRoomStateChangedEvent> getRoomStateStream() {
    return ZegoPluginAdapter()
        .signalingPlugin!
        .getRoomStateChangedEventStream();
  }
}
