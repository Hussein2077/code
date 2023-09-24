import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/send_code_usecase.dart';
part 'send_code_event.dart';
part 'send_code_state.dart';

class SendCodeBloc extends Bloc<SendCodeEvent, SendCodeState> {
  final SendCodeUseCase sendCodeUseCase ; 
  SendCodeBloc({required this.sendCodeUseCase}) : super(SendCodeInitial()) {
    on<SendPhoneEvent>((event, emit)async {
      emit(SendCodeLoadingState());
    final sendOrFailur = await sendCodeUseCase(event.phoneNumber);
   sendOrFailur.fold((l) => emit(
          const SendCodeSuccesMessageState(succesMessage: ConstentApi.seccessSendPhoneRequest)),
           (r) => emit( SendCodeErrorMessageState(
               errorMessage: DioHelper().getTypeOfFailure(r))));
    
    });
  }
}
