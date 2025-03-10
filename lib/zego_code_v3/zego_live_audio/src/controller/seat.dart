// //part of 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_controller.dart';
//
// import 'package:flutter/widgets.dart';
// import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/permissions.dart';
// import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/defines.dart';
// import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/core_managers.dart';
// import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';
// import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';
//
// /// @nodoc
// extension ZegoLiveAudioRoomControllerSeat on ZegoLiveAudioRoomController {
//   /// The speaker can use this method to leave the seat. If the showDialog parameter is set to true, a confirmation dialog will be displayed before leaving the seat.
//   Future<bool> leaveSeat({bool showDialog = true}) async {
//     return await seatManager?.leaveSeat(showDialog: showDialog) ?? false;
//   }
//
//   /// Assigns the audience to the seat with the specified [index], where the index represents the seat number starting from 0.
//   Future<bool> takeSeat(int index, int test, String ownerId ) async {
//     return await seatManager?.takeOnSeat(
//           index,
//           isForce: true,
//           isUpdateOwner: true,
//           isDeleteAfterOwnerLeft: true,
//           ownerId: ownerId,
//         ) ??
//         false;
//   }
//
//   /// Removes the speaker with the user ID [userID] from the seat.
//   Future<void> removeSpeakerFromSeat(String userID) async {
//     final index = seatManager?.getIndexByUserID(userID) ?? -1;
//     return seatManager?.kickSeat(index,userID);
//   }
//
//   /// Closes (locks) the seat. After closing the seat, audience members need to request permission from the host or be invited by the host to occupy the seat.
//   Future<bool> closeSeats() async {
//     return await seatManager?.lockSeat(true) ?? false;
//   }
//
//   /// Opens (unlocks) the seat. After opening the seat, all audience members can freely choose an empty seat to join and start chatting with others.
//   Future<bool> openSeats() async {
//     return await seatManager?.lockSeat(false) ?? false;
//   }
//
//   //--------start of audience request take seat's api--------------
//
//   /// The audience actively requests to occupy a seat.
//   Future<bool> applyToTakeSeat() async {
//     if (seatManager?.hostsNotifier.value.isEmpty ?? false) {
//       ZegoLoggerService.logInfo(
//         'Failed to apply for take seat, host is not exist',
//         tag: 'audio room',
//         subTag: 'controller',
//       );
//       return false;
//     }
//
//     return ZegoUIKit()
//         .getSignalingPlugin()
//         .sendInvitation(
//           inviterID: ZegoUIKit().getLocalUser().id,
//           inviterName: ZegoUIKit().getLocalUser().name,
//           invitees: seatManager?.hostsNotifier.value ?? [],
//           timeout: 60,
//           type: ZegoInvitationType.requestTakeSeat.value,
//           data: '',
//         )
//         .then((ZegoSignalingPluginSendInvitationResult result) {
//       ZegoLoggerService.logInfo(
//         'apply to take seat finished, code:${result.error?.code}, '
//         'message:${result.error?.message}, '
//         'invitationID:${result.invitationID}, '
//         'errorInvitees:${result.errorInvitees.keys.toList()}',
//         tag: 'audio room',
//         subTag: 'controller',
//       );
//
//       if (result.error != null) {
//         seatManager?.config.onSeatTakingRequestFailed?.call();
//       }
//
//       return result.error == null;
//     });
//   }
//
//   /// The audience cancels the request to occupy a seat.
//   Future<bool> cancelSeatTakingRequest() async {
//     return await connectManager?.audienceCancelTakeSeatRequest() ?? false;
//   }
//
//   /// The host accepts the seat request from the audience with the ID [audienceUserID].
//   Future<bool> acceptSeatTakingRequest(String audienceUserID) async {
//     return ZegoUIKit()
//         .getSignalingPlugin()
//         .acceptInvitation(inviterID: audienceUserID, data: '')
//         .then((result) {
//       ZegoLoggerService.logInfo(
//         'accept $audienceUserID seat taking request , result:$result',
//         tag: 'live audio',
//         subTag: 'controller',
//       );
//       if (result.error == null) {
//         connectManager
//             ?.removeRequestCoHostUsers(ZegoUIKit().getUser(audienceUserID));
//       } else {
//         ZegoLoggerService.logInfo(
//           'accept seat taking request error:${result.error}',
//           tag: 'audio room',
//           subTag: 'controller',
//         );
//       }
//
//       return result.error == null;
//     });
//   }
//
//   /// The host rejects the seat request from the audience with the ID [audienceUserID].
//   Future<bool> rejectSeatTakingRequest(String audienceUserID) async {
//     return ZegoUIKit()
//         .getSignalingPlugin()
//         .refuseInvitation(inviterID: audienceUserID, data: '')
//         .then((result) {
//       ZegoLoggerService.logInfo(
//         'refuse audience $audienceUserID link request, $result',
//         tag: 'live audio',
//         subTag: 'controller',
//       );
//
//       if (result.error == null) {
//         connectManager
//             ?.removeRequestCoHostUsers(ZegoUIKit().getUser(audienceUserID));
//       } else {
//         ZegoLoggerService.logInfo(
//           'reject seat taking request error:${result.error}',
//           tag: 'audio room',
//           subTag: 'controller',
//         );
//       }
//
//       return result.error == null;
//     });
//   }
//
//   //--------end of audience request take seat's api--------------
//
//   //--------start of host invite audience to take seat's api--------------
//
//   /// Host invite the audience with id [userID] to take seat
//   Future<bool> inviteAudienceToTakeSeat(String userID) async {
//     return await connectManager
//             ?.inviteAudienceConnect(ZegoUIKit().getUser(userID)) ??
//         false;
//   }
//
//   /// Accept the seat invitation from the host. The [context] parameter represents the Flutter context object.
//   Future<bool> acceptHostTakeSeatInvitation({
//     required BuildContext context,
//     bool rootNavigator = false,
//
//   }) async {
//     return ZegoUIKit()
//         .getSignalingPlugin()
//         .acceptInvitation(
//           inviterID: seatManager?.hostsNotifier.value.first ?? '',
//           data: '',
//         )
//         .then((result) async {
//       ZegoLoggerService.logInfo(
//         'accept host take seat invitation, result:$result',
//         tag: 'live audio',
//         subTag: 'controller',
//       );
//
//       if (result.error != null) {
//         ZegoLoggerService.logInfo(
//           'accept host take seat invitation error: ${result.error}',
//           tag: 'live audio',
//           subTag: 'controller',
//         );
//         return false;
//       }
//
//       return requestPermissions(
//         context: context,
//         isShowDialog: true,
//         innerText: seatManager?.innerText ?? ZegoInnerText(),
//         rootNavigator: rootNavigator,
//         kickOutNotifier: ZegoLiveAudioRoomManagers().kickOutNotifier,
//         popUpManager: ZegoLiveAudioRoomManagers().popUpManager,
//       ).then((_) async {
//         /// agree host's host, take seat, find the nearest seat index
//         return await seatManager
//                 ?.takeOnSeat(
//               seatManager?.getNearestEmptyIndex() ?? -1,
//               isForce: false,
//               isDeleteAfterOwnerLeft: true,
//           ownerId: '',
//             )
//                 .then((result) async {
//               if (result) {
//                 ZegoUIKit().turnMicrophoneOn(true);
//               }
//
//               return result;
//             }) ??
//             false;
//       });
//     });
//   }
// }
