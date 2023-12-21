import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/invitation_users_model.dart';






abstract class InvitationDetailsUsersStates extends Equatable {
  const InvitationDetailsUsersStates();

  @override
  List<Object> get props => [];
}

class InvitationDetailsDataUsersInitial extends InvitationDetailsUsersStates {}


class UsersDataLoadingUsersState extends InvitationDetailsUsersStates {}

class UsersDataScussesUsersState extends InvitationDetailsUsersStates {
  final List<InvitationUsersModel>? data;

  const UsersDataScussesUsersState({required this.data});
}

class UsersDataErorrUsersState extends InvitationDetailsUsersStates {
  final String massage;
  const UsersDataErorrUsersState({required this.massage});
}












// class GetInvitationInfoStates extends Equatable {
//   final List<InvitationUsersModel> invitaionsUsers;
//   final RequestState invitaionsUsersState;
//   final String invitaionsUsersMessage;
//   final UserDataModel invitaionsParent;
//   final RequestState invitaionsParentState;
//   final String invitaionsParentMessage;
//
//   const GetInvitationInfoStates({
//     this.invitaionsUsers = const [],
//     this.invitaionsUsersState = RequestState.loading,
//     this.invitaionsUsersMessage = "",
//     this.invitaionsParent =const UserDataModel(),
//     this.invitaionsParentState = RequestState.loading,
//     this.invitaionsParentMessage = "",
//   });
//
//   GetInvitationInfoStates copyWith({
//     List<InvitationUsersModel>? invitaionsUsers,
//     RequestState? invitaionsUsersState,
//     String? invitaionsUsersMessage,
//     UserDataModel? invitaionsParent,
//     RequestState? invitaionsParentState,
//     String? invitaionsParentMessage,
//   }) {
//     return GetInvitationInfoStates(
//       invitaionsUsers: invitaionsUsers ?? this.invitaionsUsers,
//       invitaionsUsersState: invitaionsUsersState ?? this.invitaionsUsersState,
//       invitaionsUsersMessage:
//           invitaionsUsersMessage ?? this.invitaionsUsersMessage,
//       invitaionsParent: invitaionsParent ?? this.invitaionsParent,
//       invitaionsParentState:
//           invitaionsParentState ?? this.invitaionsParentState,
//       invitaionsParentMessage:
//           invitaionsParentMessage ?? this.invitaionsParentMessage,
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         invitaionsUsersState,
//         invitaionsUsersMessage,
//         invitaionsUsers,
//         invitaionsParent,
//     invitaionsParentState,
//     invitaionsParentMessage
//
//       ];
// }
