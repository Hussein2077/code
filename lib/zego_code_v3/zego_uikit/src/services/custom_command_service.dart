
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/command.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';

/// @nodoc
mixin ZegoCustomCommandService {
  /// [toUserIDs] send to everyone if empty
  Future<bool> sendInRoomCommand(
    String command,
    List<String> toUserIDs,
  ) async {
    return ZegoUIKitCore.shared.sendInRoomCommand(command, toUserIDs);
  }

  /// get in-room command received notifier
  Stream<ZegoInRoomCommandReceivedData> getInRoomCommandReceivedStream() {
    return ZegoUIKitCore.shared.coreData.customCommandReceivedStreamCtrl.stream;
  }
}
