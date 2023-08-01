

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/back_pack_usecase.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/my_bag_manager/my_bag_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/my_bag_manager/my_bag_state.dart';

class MyBagBloc extends Bloc<MyBagEvent, MyBagState> {
 final GetBackPackUseCase getBackPackUseCase;
  MyBagBloc({required this.getBackPackUseCase})
      : super(const MyBagState()) {
    on<GetEntrieMyBagEvent>(getEntrieBackPack);
    on<GetFramesMyBagEvent>(getFrames);
    on<GetBubbleBackPackMyBagEvent>(getBubble);
  }

  FutureOr<void> getEntrieBackPack(
      GetEntrieMyBagEvent event, Emitter<MyBagState> emit) async {
    final result = await getBackPackUseCase.getBackPack(event.type);
    result.fold(
        (l) => emit(state.copyWith(
            entering: l, enteringBackPackRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            enteringBackPackRequest: RequestState.error,
            enteringBackPackMassage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getFrames(
      GetFramesMyBagEvent event, Emitter<MyBagState> emit) async {
    final result = await getBackPackUseCase.getBackPack(event.type);
    result.fold(
        (l) => emit(state.copyWith(
            framesBackPack: l, framesBackPackRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            framesBackPackRequest: RequestState.error,
            framesBackPackMassage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getBubble(
      GetBubbleBackPackMyBagEvent event, Emitter<MyBagState> emit) async {
    final result = await getBackPackUseCase.getBackPack(event.type);
    result.fold(
        (l) => emit(state.copyWith(
            bubblesPackBack: l, bubblesPackBackRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            bubblesPackBackRequest: RequestState.error,
            bubblesPackBackMassage: DioHelper().getTypeOfFailure(r))));
  }
}
