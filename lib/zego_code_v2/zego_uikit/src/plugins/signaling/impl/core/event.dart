// Dart imports:
import 'dart:async';

// Package imports:

import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/plugins/signaling/impl/core/core.dart';

mixin ZegoSignalingPluginCoreEvent {
  List<StreamSubscription<dynamic>> streamSubscriptions = [];

  void initEvent() {
    final plugin = ZegoPluginAdapter().signalingPlugin!;
    streamSubscriptions.addAll([
      plugin.getConnectionStateChangedEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onConnectionStateChanged,
          ),
      plugin.getRoomStateChangedEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onRoomStateChanged,
          ),
      plugin.getErrorEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onError,
          ),
      plugin.getNotificationArrivedEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onNotificationArrived,
          ),
      plugin.getNotificationClickedEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onNotificationClicked,
          ),
      plugin.getNotificationRegisteredEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onNotificationRegistered,
          ),
      plugin.getIncomingInvitationReceivedEventStream().listen(
            ZegoSignalingPluginCore
                .shared.coreData.onIncomingInvitationReceived,
          ),
      plugin.getIncomingInvitationCancelledEventStream().listen(
            ZegoSignalingPluginCore
                .shared.coreData.onIncomingInvitationCancelled,
          ),
      plugin.getOutgoingInvitationAcceptedEventStream().listen(
            ZegoSignalingPluginCore
                .shared.coreData.onOutgoingInvitationAccepted,
          ),
      plugin.getOutgoingInvitationRejectedEventStream().listen(
            ZegoSignalingPluginCore
                .shared.coreData.onOutgoingInvitationRejected,
          ),
      plugin.getIncomingInvitationTimeoutEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onIncomingInvitationTimeout,
          ),
      plugin.getOutgoingInvitationTimeoutEventStream().listen(
            ZegoSignalingPluginCore.shared.coreData.onOutgoingInvitationTimeout,
          ),
    ]);
  }

  void uninitEvent() {
    for (final subscription in streamSubscriptions) {
      subscription.cancel();
    }
  }
}
