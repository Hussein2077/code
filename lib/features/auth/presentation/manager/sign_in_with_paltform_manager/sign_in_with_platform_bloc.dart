
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/google_sign_in_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/sign_with_huawei_use_case.dart';
import '../../../domin/use_case/sign_with_apple_us.dart';
import 'sign_in_with_platform_event.dart';
import 'sign_in_with_platform_state.dart';

class SignInWithPlatformBloc extends Bloc<BaseSignInWithPlatformEvent, SignInWithPlatformState> {
  final SignInWithGoogleUC signInWithGoogleUC;
  final SignInWithAppleUC signInWithAppleUC;
  final SignInWithHuaweiUC signInWithHuaweiUC;

  SignInWithPlatformBloc({
    required this.signInWithGoogleUC,
    required this.signInWithAppleUC,
    required this.signInWithHuaweiUC,
  }) : super(SignInWithPlatformInitial()) {
    on<SiginGoogleEvent>((event, emit) async {
      emit(const SiginWithPlatFormLoadingState());
      final result = await signInWithGoogleUC.call(const Noparamiter());
      result.fold(
          (l) => emit(SiginWithGoogleSuccesMessageState(userData: l)),
          (r) => emit(SiginWithGoogleErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(r))));
    });

    on<SiginAppleEvent>((event, emit) async {
      emit(const SiginWithPlatFormLoadingState());
      final signinOrFailur = await signInWithAppleUC.call(const Noparamiter());
      signinOrFailur.fold(
              (l) => emit(SiginWithAppleSuccesMessageState(succesMessage:"Sign In Succesfully", userModel: l)),
              (r) => emit(SiginWithAppleErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(r))));
    });

    on<SiginHuaweiEvent>((event, emit) async {
      emit(const SiginWithPlatFormLoadingState());
      final signinOrFailur = await signInWithHuaweiUC.call(const Noparamiter());
      signinOrFailur.fold(
              (l) => emit(SiginWithHuaweiSuccesMessageState(succesMessage:"Sign In Succesfully", userModel: l)),
              (r) => emit(SiginWithHuaweiErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(r))));
    });

  }
}
