




import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/invitation_code/get_parent_details_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitation_parent_bloc/get_invitations_parent_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitation_parent_bloc/get_invitations_parent_state.dart';

class GetInvitationParentDetailsBloc
    extends Bloc<GetInVitationsParentEvents, InvitationDetailsParentStates> {
  final GetParentDetailsUsecase getParentDetailsUsecase;

  GetInvitationParentDetailsBloc({
    required this.getParentDetailsUsecase,
  }) : super(InvitationDetailsDataInitial()) {
    on<GetParentDetailsParentEvent>(getInvitationParent);
  }


  FutureOr<void> getInvitationParent(GetParentDetailsParentEvent event,
      Emitter<InvitationDetailsParentStates> emit) async {
    emit(ParentDataLoadingState());
    final result = await getParentDetailsUsecase.call();
    result.fold(
        (l) => emit(ParentDataScussesState(parentStaticsModel: l)),
        (r) => emit(
            ParentDataErorrState(massage: DioHelper().getTypeOfFailure(r))));
  }
}
