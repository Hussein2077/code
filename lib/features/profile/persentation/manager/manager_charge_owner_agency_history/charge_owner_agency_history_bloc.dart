

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_dolars_agency_owner_history.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_owner_agency_history/charge_owner_agency_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_owner_agency_history/charge_owner_agency_history_state.dart';






class ChargeOwnerAgencyHistoryBloc extends Bloc<ChargeOwnerAgencyHistoryEvent, ChargeOwnerAgencyHistoryState> {
  GetChargeDolarsAgencyOwnerHistoryUseCase chargeHistoryUseCases;

  ChargeOwnerAgencyHistoryBloc({required this.chargeHistoryUseCases})
      : super(const ChargeOwnerAgencyHistoryState()) {
    on<ChargeSentHistory>(sent);
        on<ChargeRecivedHistory>(recived);


  }

  FutureOr<void> sent(ChargeSentHistory event, Emitter<ChargeOwnerAgencyHistoryState> emit) async {
    final result = await chargeHistoryUseCases.call(event.sent);

    result.fold(
        (l) => emit(state.copyWith(sent: l,sentState: RequestState.loaded)),
        (r) => emit(
            state.copyWith(sentMessage: DioHelper().getTypeOfFailure(r),sentState: RequestState.error)));
  }

  FutureOr<void> recived(ChargeRecivedHistory event, Emitter<ChargeOwnerAgencyHistoryState> emit) async {
    final result = await chargeHistoryUseCases.call(event.recived);

    result.fold(
        (l) => emit(state.copyWith(recived: l,recivedState: RequestState.loaded)),
        (r) => emit(
            state.copyWith(recivedMessage: DioHelper().getTypeOfFailure(r),recivedState: RequestState.error)));
  }
}