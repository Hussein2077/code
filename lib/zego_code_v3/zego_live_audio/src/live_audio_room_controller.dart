// Flutter imports:

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/controller_p.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/message.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/core_managers.dart';
//import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/minimizing/mini_overlay_machine.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';


// Package imports:


// Project imports:

// part 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/media.dart';
//
// part 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/message.dart';
//
// part 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/seat.dart';
//
// part 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/controller/controller_p.dart';

/// Used to control the audio chat room functionality.
///
/// If the default audio chat room UI and interactions do not meet your requirements, you can use this [ZegoLiveAudioRoomController] to actively control the business logic.
/// This class is used by setting the [controller] parameter in the constructor of [ZegoUIKitPrebuiltLiveAudioRoom].
class ZegoLiveAudioRoomController
    with
        ZegoLiveAudioRoomControllerPrivate
{
  ///  enable or disable the microphone of a specified user. If userID is empty or null, it controls the local microphone. The isOn parameter specifies whether the microphone should be turned on or off, where true means it is turned on and false means it is turned off.
  void turnMicrophoneOn(bool isOn, {String? userID}) {
    ZegoUIKit().turnMicrophoneOn(isOn,userID: userID);
  }


  Future<bool> leave(
    BuildContext context, {
    bool showConfirmation = true,
  }) async {
    if (null == seatManager) {
      ZegoLoggerService.logInfo(
        'leave, param is invalid, seatManager:$seatManager',
        tag: 'audio room',
        subTag: 'controller',
      );

      return false;
    }

    if (seatManager?.isLeavingRoom ?? false) {
      ZegoLoggerService.logInfo(
        'leave, is leave requesting...',
        tag: 'audio room',
        subTag: 'controller',
      );

      return false;
    }

    if (seatManager?.isRoomAttributesBatching ?? false) {
      ZegoLoggerService.logInfo(
        'room attribute is batching, ignore',
        tag: 'audio room',
        subTag: 'leave button',
      );
      return false;
    }

    ZegoLoggerService.logInfo(
      'leave, show confirmation:$showConfirmation',
      tag: 'audio room',
      subTag: 'controller',
    );

    if (showConfirmation) {
      ///  if there is a user-defined event before the click,
      ///  wait the synchronize execution result
      final canLeave =
          await prebuiltConfig?.onLeaveConfirmation?.call(context) ?? true;
      if (!canLeave) {
        ZegoLoggerService.logInfo(
          'leave, refuse',
          tag: 'audio room',
          subTag: 'controller',
        );

        return false;
      }

      /// take off seat when leave room
      await seatManager?.leaveSeat(showDialog: false);
      seatManager?.isLeavingRoom = true;
    }


    final result = await ZegoUIKit().leaveRoom().then((result) {
      ZegoLoggerService.logInfo(
        'leave, leave room result, ${result.errorCode} ${result.extendedData}',
        tag: 'audio room',
        subTag: 'controller',
      );

      return 0 == result.errorCode;
    });


      if (prebuiltConfig?.onLeaveLiveAudioRoom != null) {
        prebuiltConfig?.onLeaveLiveAudioRoom!.call(false);
      } else {
        Navigator.of(
          context,
          rootNavigator: prebuiltConfig?.rootNavigator ?? true,
        ).pop();
      }


    uninitByPrebuilt();

    ZegoLoggerService.logInfo(
      'leave, finished',
      tag: 'audio room',
      subTag: 'controller',
    );

    return result;
  }

  ///--------end of host invite audience to take seat's api--------------

  ///
  void hideInMemberList(List<String> userIDs) {
    hiddenUsersOfMemberListNotifier.value = List<String>.from(userIDs);
  }
}
