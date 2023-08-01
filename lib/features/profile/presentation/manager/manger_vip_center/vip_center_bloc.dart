

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_vip_center_usecase.dart';

import 'vip_center_events.dart';
import 'vip_center_states.dart';




class VipCenterBloc extends Bloc<VipCenterEvents, VipStates> {
  final GetVipCenterUsecase getVipCenterUsecase;


  VipCenterBloc(
      {required this.getVipCenterUsecase})
      : super(const VipStatesInitialState()) {

    on<GetVipCenterEvent>(getVipCenter);
  }

  FutureOr<void> getVipCenter(
      GetVipCenterEvent event, Emitter<VipStates> emit) async {
    emit(const VipStatesLoadingState());
    final result = await getVipCenterUsecase.getVipCenter();
    result.fold(
        (l) => emit(VipStatesSuccessState(vipData: l)),
        (r) =>
            emit(VipStatesErrorState(message: DioHelper().getTypeOfFailure(r))));
  }


}
