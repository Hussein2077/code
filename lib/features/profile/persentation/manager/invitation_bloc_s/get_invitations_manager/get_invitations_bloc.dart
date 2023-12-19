import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/invitation_code/get_invitation_details_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/invitation_code/get_parent_details_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_manager/get_invitations_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_manager/get_invitations_state.dart';

class GetInvitationBloc
    extends Bloc<GetInVitationsEvents, InvitationDetailsDataStates> {
  final GetInvitationsDetailsUsecase getInvitationsDetailsUsecase;
  final GetParentDetailsUsecase getParentDetailsUsecase;

  GetInvitationBloc({
    required this.getInvitationsDetailsUsecase,
    required this.getParentDetailsUsecase,
  }) : super(InvitationDetailsDataInitial()) {
    on<GetInVitationsDetailsEvent>(getInvitationUsers);
    on<GetParentDetailsEvent>(getInvitationParent);
  }

  FutureOr<void> getInvitationUsers(GetInVitationsDetailsEvent event,
      Emitter<InvitationDetailsDataStates> emit) async {
    emit(UsersDataLoadingState());
    final result = await getInvitationsDetailsUsecase.call();
    result.fold(
        (l) => emit(UsersDataScussesState(data: l)),
        (r) => emit(
            UsersDataErorrState(massage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getInvitationParent(GetParentDetailsEvent event,
      Emitter<InvitationDetailsDataStates> emit) async {
    emit(ParentDataLoadingState());
    final result = await getParentDetailsUsecase.call();
    result.fold(
        (l) => emit(ParentDataScussesState(parentStaticsModel: l)),
        (r) => emit(
            ParentDataErorrState(massage: DioHelper().getTypeOfFailure(r))));
  }
}
