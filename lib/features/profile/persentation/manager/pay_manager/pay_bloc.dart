import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/pay_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_states.dart';


class PayBloc extends Bloc<PayEvent, payState> {
  PayUsecase payUsecase;
  PayBloc({required this.payUsecase}) : super(payInitial()) {

    on<PayNow>((event, emit) async {
      emit(payLoadingState());
      final result = await payUsecase.pay(message: event.message, type: event.type, token: event.token);
      result.fold((l) => emit(paySucssesState(massege: l)),
              (r) => emit(payErrorState(massege: DioHelper().getTypeOfFailure(r))));
    });

  }

}
