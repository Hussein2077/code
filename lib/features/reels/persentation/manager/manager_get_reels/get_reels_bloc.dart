


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_reels_use_case.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_state.dart';

class GetReelsBloc extends Bloc<BaseGetReelsEvent, GetReelsState> {
  final GetReelUseCase getReelUseCase ; 
  int page = 1 ; 
  GetReelsBloc({required this.getReelUseCase}) : super(GetReelsInitial(null)) {
    on<GetReelsEvent>((event, emit)async {
      page = 1 ; 
    emit(GetReelsLoadingState(null));
    final result = await getReelUseCase.getReel("1");
    result.fold((l) => emit(GetReelsSucssesState(data: l)), (r) => emit(GetReelsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });


        on<LoadMoreReelsEvent>((event, emit)async {
          page++ ; 
    final result = await getReelUseCase.getReel(page.toString());
    result.fold((l) {  if (l != []) {
          emit(
              GetReelsSucssesState(data: [...state.data!, ...l]));
        }}, (r) => emit(GetReelsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });
  }

  
  
}
