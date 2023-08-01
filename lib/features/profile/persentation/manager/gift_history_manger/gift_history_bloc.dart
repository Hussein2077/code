

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/gift_history_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_state.dart';



class GiftHistoryBloc extends Bloc<GiftHistoryEvent, BaseGiftHistoryState> {
  GiftHistorykUseCase giftHistorykUseCase; 
  GiftHistoryBloc({required this.giftHistorykUseCase}) : super(GiftHistoryInitial()) {
    on<GetGiftHistory>((event, emit)async {
       emit(GiftHistoryLoadingState());
      final result = await giftHistorykUseCase.getGiftHistory(event.id);

      result.fold(
          (l) => emit(GiftHistorySucssesState(
               data: l,
              )),
          (r) =>
              emit(GiftHistoryErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
