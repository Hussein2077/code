

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/login_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_state.dart';

class LoginWithPhoneBloc extends Bloc<BaseLoginWithPhoneEvent, LoginWithPhoneState> {
    LoginWithPhoneUseCase loginWithPhoneUseCase ;

  LoginWithPhoneBloc({required this.loginWithPhoneUseCase}) : super(LoginWithPhoneInitial()) {
    on<LoginWithPhoneEvent>((event, emit) async{
          emit(const LoginWithPhoneLoadingState());
    final sendOrFailur = await loginWithPhoneUseCase.call(AuthPramiter(phone: event.phone ,password: event.password));

    sendOrFailur.fold(
        (l) => emit( LoginWithPhoneSuccesMessageState(
            userModel: l, succesMessage: StringManager.loginSuccesfully)),
        (r) => emit( LoginWithPhoneErrorMessageState(
            errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
