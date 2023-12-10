import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_check_code_us.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/reset_password_uc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEventBase, ForgetPasswordState> {
  final ForgetPasswordUc forgetPasswordUc;
  final ForgetPasswordCheckCodeUc forgetPasswordCheckCodeUc;
  final ResetPasswordUc resetPasswordUC;

  ForgetPasswordBloc({
    required this.forgetPasswordUc,
    required this.forgetPasswordCheckCodeUc,
    required this.resetPasswordUC,
  }) : super(ForgetPasswordInitialState()) {
    on<ForgetPasswordEvent>((event, emit) async {
      emit(ForgetPasswordLoadingState());
      final sendOrFailur = await forgetPasswordUc(event.phone);

      sendOrFailur.fold(
          (l) => emit(ForgetPasswordSuccessState(message: l)),
          (r) => emit(ForgetPasswordErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<CheckCodeForgetPasswordEvent>((event, emit) async {
      emit(CheckCodeForgetPasswordLoadingState());
      final sendOrFailur = await forgetPasswordCheckCodeUc(
          ForgetPasswordCheckCodeParameters(
              phone: event.phone, code: event.code));
      sendOrFailur.fold(
          (l) => emit(CheckCodeForgetPasswordSuccessState(message: l)),
          (r) => emit(CheckCodeForgetPasswordErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(ResetPasswordLoadingState());
      final sendOrFailur = await resetPasswordUC(ResetPasswordPramiter(
          phone: event.phone, code: event.code, password: event.password));
      log('eveeeenttt');
      sendOrFailur.fold(
          (l) => emit(ResetPasswordSuccessState(message: l)),
          (r) => emit(ResetPasswordErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
