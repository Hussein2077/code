
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_gold_coin_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_state.dart';



class GoldCoinBloc extends Bloc<GoldCoinEvent, GoldCoinState> {
    GetGoldCoinDataUseCase getGoldCoinDataUseCase ;

  GoldCoinBloc({required this.getGoldCoinDataUseCase}) : super(GoldCoinInitial()) {
    on<GetGoldCoinDataEvent>((event, emit)async {
      emit(GoldCoinLoadingState());
      final result = await getGoldCoinDataUseCase.getGoldCoinData();

      result.fold(
          (l) => emit(GoldCoinSucssesState(
                data: l,
              )),
          (r) =>
              emit(GoldCoinErrorState(error: DioHelper().getTypeOfFailure(r))));
    });

    // on<RechargeCoinsEvent>((event, emit)async {
    //   emit(RechargeCoinLoadingState());
    //   final result = await paymentUC.payment(event.packageCoinId);
    //
    //   result.fold(
    //           (l) => emit(RechargeCoinSucssesState(
    //         urlWeb: l,
    //       )),
    //           (r) =>
    //           emit(RechargeCoinErrorState(measssageError: DioHelper().getTypeOfFailure(r))));
    // });
  }
}
