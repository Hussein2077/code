

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_coin_for_users_history_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_system_history/charge_coin_system_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_system_history/charge_coin_system_history_state.dart';





class ChargeCoinSystemHistoryBloc extends Bloc<ChargeCoinSystemHistoryEvent, ChargeCoinSystemHistoryState> {
  GetChargeCoinsSystemHistoryUseCases chargeHistoryUseCases;

  ChargeCoinSystemHistoryBloc({required this.chargeHistoryUseCases})
      : super(const ChargeCoinSystemHistoryState()) {
    on<ChargeSentHistory>(sent);
        on<ChargeRecivedHistory>(recived);


  }

  FutureOr<void> sent(ChargeSentHistory event, Emitter<ChargeCoinSystemHistoryState> emit) async {
    final result = await chargeHistoryUseCases.call(event.sent);

    result.fold(
        (l) => emit(state.copyWith(sent: l,sentState: RequestState.loaded)),
        (r) => emit(
            state.copyWith(sentMessage: DioHelper().getTypeOfFailure(r),sentState: RequestState.error)));
  }

  FutureOr<void> recived(ChargeRecivedHistory event, Emitter<ChargeCoinSystemHistoryState> emit) async {
    final result = await chargeHistoryUseCases.call(event.recived);

    result.fold(
        (l) => emit(state.copyWith(recived: l,recivedState: RequestState.loaded)),
        (r) => emit(
            state.copyWith(recivedMessage: DioHelper().getTypeOfFailure(r),recivedState: RequestState.error)));
  }
}