
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_state.dart';

class BuyCoinsBloc extends Bloc<BuyCoinsEvent, BuyCoinsState> {
  BuyCoinsUseCase buyCoinsUseCase;
  BuyCoinsBloc({required this.buyCoinsUseCase}) : super(BuyCoinsInitial()) {
    on<BuyCoins>(buyCoins);
  }

  FutureOr<void> buyCoins(BuyCoins event, Emitter<BuyCoinsState> emit) async {
    emit(BuyCoinsLoadingState());
    final result = await buyCoinsUseCase.buyCoins(BuyCoinsParameter(
        coinsID: event.buyCoinsParameter.coinsID,
        paymentMethod: event.buyCoinsParameter.paymentMethod));
    result.fold((l) => emit(BuyCoinsSuccessState(susses: l)),
            (r) => emit(BuyCoinsErrorState(error: DioHelper().getTypeOfFailure(r))));

  }
}
