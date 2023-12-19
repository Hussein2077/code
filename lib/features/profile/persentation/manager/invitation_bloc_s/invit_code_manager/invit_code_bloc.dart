import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/invitation_code/invit_code_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_state.dart';

class InvitCodeBloc extends Bloc<InvitCodeEvents, InvitCodeState> {
  final InvitUsecase invitUsecase;

  InvitCodeBloc({required this.invitUsecase}) : super(InvitCodeInitial()) {
    on<InvitCodeEvent>((event, emit) async {
      emit(InvitCodeLoadingState());
      final result = await invitUsecase.call(event.id);
      result.fold(
          (l) => emit(InvitCodeScussesState(massage: l)),
          (r) => emit(
              InvitCodeErorrState(massage: DioHelper().getTypeOfFailure(r))));
    });
    on<InvitCodeEventInitial>((event, emit) async {
      emit(InvitCodeInitial());
    });
  }
}
