

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_likes_uc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_state.dart';




class GetMomentLikesBloc extends Bloc<BaseGetMomentLikesEvent, GetMomentLikesState> {
    final GetMomentLikeUseCase  getMomentLikeUseCase ; 
  int page = 1 ; 
  GetMomentLikesBloc({required this.getMomentLikeUseCase}) : super(GetMomentLikeInitial(null)) {
    on<GetMomentLikesEvent>((event, emit)async {
      page = 1 ; 
    emit(GetMomentLikeLoadingState(null));
    final result = await getMomentLikeUseCase.call(GetMomentLikePrameter(momentId: event.momentId , page: page.toString()));
    result.fold((l) => emit(GetMomentLikeSucssesState(data: l)), (r) => emit(GetMomentLikeErrorState(null, DioHelper().getTypeOfFailure(r))));
    });


        on<GetMoreMomentLikesEvent>((event, emit)async {
          page++ ; 
    final result = await getMomentLikeUseCase.call(GetMomentLikePrameter(momentId: event.momentId , page: page.toString()));
    result.fold((l) {  if (l != []) {
          emit(
              GetMomentLikeSucssesState(data: [...state.data!, ...l]));
        }}, (r) => emit(GetMomentLikeErrorState(null, DioHelper().getTypeOfFailure(r))));
    });
  }
}
