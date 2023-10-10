

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_reels_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';

class GetUserReelsBloc extends Bloc<BaseGetUserReelsEvent, GetUserReelsState> {
final GetUserReelsUsecase getUserReelUseCase ; 
  int page = 1 ;
  bool loadMore = true;

  GetUserReelsBloc({required this.getUserReelUseCase}) : super(GetUserReelsInitial(null)) {
    on<GetUserReelEvent>((event, emit)async {
      page = 1 ; 
    emit(GetUserReelsLoadingState(null));
    final result = await getUserReelUseCase.getUserReels(event.id , page.toString() );
    result.fold((l) {
      loadMore = true;
      emit(GetUserReelsSucssesState(data: l, loadMore: true, ));}, (r) => emit(GetReelUsersErrorState(null, DioHelper().getTypeOfFailure(r))));
    });


        on<LoadMoreUserReelsEvent>((event, emit)async {
          page++ ;
          if(loadMore) {
            final result = await getUserReelUseCase.getUserReels(event.id, page.toString());
            result.fold((l) {
              if (l.isNotEmpty) {
                emit(GetUserReelsSucssesState(data: [...state.data!, ...l], loadMore: true));
              }else {
                loadMore = false;
                emit(GetUserReelsSucssesState(data: [...state.data!, ...l], loadMore: false));
              }
            }, (r) => emit(GetReelUsersErrorState(null, DioHelper().getTypeOfFailure(r))));
          }
    });
  }

  
}
