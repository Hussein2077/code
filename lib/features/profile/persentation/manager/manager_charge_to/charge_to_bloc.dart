

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_to_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_to/charge_to_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_to/charge_to_state.dart';




class ChargeToBloc extends Bloc<ChargeToEvents, ChargeToState> {
  final ChargeToUseCases chargeToUseCases;

  ChargeToBloc({required this.chargeToUseCases}) : super(ChargeToInitial()) {
    on<SendCharge>(sendCoin);
  }

  FutureOr<void> sendCoin(SendCharge event, Emitter<ChargeToState> emit) async {
    emit(ChargeToLoadingState());
    final result = await chargeToUseCases.call(ChargeToPramiter(toId: event.uId,usd: event.usd));

    result.fold((l) => emit(ChargeToSuccessState(chargeToModel: l)),
        (r) => emit(ChargeToErrorState(error: DioHelper().getTypeOfFailure(r))));
  }
}
