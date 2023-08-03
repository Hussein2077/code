import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_history_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_state.dart';



class ChargeHistoryBloc extends Bloc<ChargeHistoryEvent, ChargeHistoryState> {
  ChargeHistoryUseCases chargeHistoryUseCases;

  ChargeHistoryBloc({required this.chargeHistoryUseCases})
      : super(ChargeHistoryInitial()) {
    on<ChargeHistory>(sent);

  }

  FutureOr<void> sent(ChargeHistory event, Emitter<ChargeHistoryState> emit) async {
    emit(ChargeHistoryLoadingReceived());
    final result = await chargeHistoryUseCases.call(event.sent);

    result.fold(
        (l) => emit(ChargeHistorySuccessReceivedState(received: l)),
        (r) => emit(
            ChargeHistoryErrorReceivedState(error: DioHelper().getTypeOfFailure(r))));
  }
}
