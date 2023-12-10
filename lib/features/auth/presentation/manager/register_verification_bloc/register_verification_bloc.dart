import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_verification_us.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_verification_bloc/Register_verification_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_verification_bloc/register_verification_states.dart';
//new bloc
class RegisterVerificationBloc
    extends Bloc<RegisterVerificationEventBase, RegisterVerificationState> {
  final RegisterVerificationUseCase registerVerificationUseCase;

  RegisterVerificationBloc({required this.registerVerificationUseCase})
      : super(RegisterVerificationInitial()) {
    on<RegisterVerificationEvent>((event, emit) async {
      emit(RegisterVerificationLoadingState());
      final sendOrFailur = await registerVerificationUseCase(
          RegisterVerificationModel(
              uuid: event.uuid, code: event.code, deviceID: event.deviceID));
      sendOrFailur.fold(
          (l) => emit( RegisterVerificationSuccessMessageState()),
          (r) => emit(RegisterVerificationErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
