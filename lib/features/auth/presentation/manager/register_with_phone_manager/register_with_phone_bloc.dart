

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';

import 'register_with_phone_event.dart';
import 'register_with_phone_state.dart';

class RegisterWithPhoneBloc extends Bloc<BaseRegisterWithPhoneEvent, RegisterWithPhoneState> {
  final RegisterWithPhoneUsecase registerWithPhoneUsecase ;
  RegisterWithPhoneBloc({required this.registerWithPhoneUsecase}) : super(RegisterWithPhoneInitial()) {
    on<RegisterWithPhoneEvent>((event, emit) async{
        emit( RegisterPhoneLoadingMessageState());
    final sendOrFailur = await registerWithPhoneUsecase.call(
        AuthPramiter(phone: event.phone,password: event.password,code: event.code));
    sendOrFailur.fold(
            (l) => emit( RegisterPhoneSuccesMessageState(
            myDataModel: l, succesMessage: StringManager.loginSuccesfully)),
            (r) => emit( RegisterPhoneErrorMessageState(
            errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
