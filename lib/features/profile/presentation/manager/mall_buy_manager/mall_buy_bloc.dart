
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_usecase.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/mall_buy_manager/mall_buy_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/mall_buy_manager/mall_buy_state.dart';

class MallBuyBloc extends Bloc<MallBuyEvent, MallBuyState> {
 final BuyUseCase buyUseCase;
  MallBuyBloc({required this.buyUseCase}) : super(BuyInitial()) {
    on<BuyItemEvent>(buy);
  }

  FutureOr<void> buy(BuyItemEvent event, Emitter<MallBuyState> emit) async {
    emit(BuyLoadingState());
    final result = await buyUseCase.buy(event.idItem, event.quantity);

    result.fold((l) => emit(BuyScussesState(massage: l)),
        (r) => emit(BuyErorrState(massage: DioHelper().getTypeOfFailure(r))));
  }
}
