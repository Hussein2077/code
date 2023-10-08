import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_gifts_uc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_state.dart';

class GetMomentGiftsBloc
    extends Bloc<BaseGetMomentGiftsEvent, BaseGetMomentsGiftsStates> {
  GetMomentGiftsUseCase getMomentGiftsUseCase;
  int page = 1;

  GetMomentGiftsBloc({required this.getMomentGiftsUseCase})
      : super(GetMomentsGiftsInitialState(null)) {
    on<GetMomentGiftsEvent>((event, emit) async {
      page = 1;
      emit(GetMomentsGiftsloadingState(null));
      final result = await getMomentGiftsUseCase.call(GetMomentGiftsPrameter(
          page: page.toString(), momentId: event.momentId));
      result.fold((l) => emit(GetMomentsGiftsSuccessState(data: l)), (r) => emit(GetMomentsGiftsErrorState(null,DioHelper().getTypeOfFailure(r))));
    });


    on<LoadMoreMomentGiftsEvent>((event, emit) async {
      page ++;
      final result = await getMomentGiftsUseCase.call(GetMomentGiftsPrameter(
          page: page.toString(), momentId: event.momentId));
      result.fold((l) => {
        if (l != [])      emit(GetMomentsGiftsSuccessState(data: [...state.data!,...l]))
      }, (r) => emit(GetMomentsGiftsErrorState(null,DioHelper().getTypeOfFailure(r))));
    });



  }
}
