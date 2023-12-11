import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_code_verification_uc.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_usecase.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEventBase, ForgetPasswordState> {
  final ForgetPasswordUc forgetPasswordUc;
  final ForgetPasswordCodeVerificationUc forgetPasswordCodeVerificationUc;

  ForgetPasswordBloc({
    required this.forgetPasswordUc,
    required this.forgetPasswordCodeVerificationUc,
  }) : super(ForgetPasswordInitialState()) {

    on<ForgetPasswordEvent>((event, emit) async {
      emit(ForgetPasswordLoadingState());
      final sendOrFailur = await forgetPasswordUc(phone: event.phone, password: event.password, code: event.code);

      sendOrFailur.fold(
          (l) => emit(ForgetPasswordSuccessState(message: l)),
          (r) => emit(ForgetPasswordErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

    on<forgetPasswordCodeVerificationEvent>((event, emit) async {
      emit(ForgetPasswordCodeVerificationLoadingState());
      final sendOrFailur = await forgetPasswordCodeVerificationUc(phone: event.phone, code: event.code);

      sendOrFailur.fold(
              (l) => emit(ForgetPasswordCodeVerificationSuccessState(message: l)),
              (r) => emit(ForgetPasswordCodeVerificationErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
