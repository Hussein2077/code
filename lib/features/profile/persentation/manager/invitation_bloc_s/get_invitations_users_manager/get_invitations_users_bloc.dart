import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/invitation_code/get_invitation_details_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_users_manager/get_invitations_users_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_users_manager/get_invitations_users_users_event.dart';

class GetInvitationUsersDetailsBloc
    extends Bloc<GetInVitationsEvents, InvitationDetailsUsersStates> {
  final GetInvitationsDetailsUsecase getInvitationsDetailsUsecase;

  GetInvitationUsersDetailsBloc({
    required this.getInvitationsDetailsUsecase,
  }) : super(InvitationDetailsDataUsersInitial()) {
    on<GetInVitationsUsersDetailsEvent>(getInvitationUsers);
  }

  FutureOr<void> getInvitationUsers(GetInVitationsUsersDetailsEvent event,
      Emitter<InvitationDetailsUsersStates> emit) async {
    emit(UsersDataLoadingUsersState());
    final result = await getInvitationsDetailsUsecase.call();
    result.fold(
            (l) => emit(UsersDataScussesUsersState(data: l)),
            (r) => emit(
            UsersDataErorrUsersState(massage: DioHelper().getTypeOfFailure(r))));
  }


}
