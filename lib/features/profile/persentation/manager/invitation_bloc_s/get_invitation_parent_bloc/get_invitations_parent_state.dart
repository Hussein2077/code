import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/invitation_users_model.dart';






abstract class InvitationDetailsParentStates extends Equatable {
  const InvitationDetailsParentStates();

  @override
  List<Object> get props => [];
}

class InvitationDetailsDataInitial extends InvitationDetailsParentStates {}

class ParentDataLoadingState extends InvitationDetailsParentStates {}

class ParentDataScussesState extends InvitationDetailsParentStates {
  final ParentStaticsModel parentStaticsModel;

  const ParentDataScussesState({required this.parentStaticsModel});
}

class ParentDataErorrState extends InvitationDetailsParentStates {
  final String massage;
  const ParentDataErorrState({required this.massage});
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
