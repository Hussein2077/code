
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/unused_item_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/use_item_usecase.dart';

import 'use_item_event.dart';
import 'use_item_state.dart';


class UseItemBloc extends Bloc<UseItemEvent, UseItemState> {
  UseItemUseCase useItemUseCase;
  UnusedItemUsecase unusedItemUsecase;
  UseItemBloc({required this.useItemUseCase,required this.unusedItemUsecase}) : super(UseItemInitial()) {
    on<UserItemsEvent>((event, emit) async {
      
      emit(UseItemLoadingState());
      final result = await useItemUseCase.useItem(event.id);
      
      result.fold((l) => emit(UseItemSuccseesState(data: l)),
          (r) => emit(UseItemErrorState(error: DioHelper().getTypeOfFailure(r))));
    });

    on<UnUsedItemEvent>((event, emit) async {
      emit(UnusedloadingState());
      final result = await unusedItemUsecase.unUsedItem(event.id);
      result.fold(
              (l) => emit(UnusedSucssesState(massage: l)),
              (r) =>
              emit(UnusedErrorState(massage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
