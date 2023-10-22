import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_following_reels_uc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_state.dart';

class GetFollowingReelsBloc extends Bloc<BaseGetFollowingReelsEvent, GetFollowingReelsState> {
  final GetFollowingReelUseCase getFollowingReelUseCase ;
  int page = 1 ;
  bool loadMore = true;





  GetFollowingReelsBloc({required this.getFollowingReelUseCase}) : super(GetFollowingReelsInitial(null)) {
    on<GetFollowingReelsEvent>((event, emit)async {
      page = 1 ;
      emit(GetFollowingReelsLoadingState(null));
      final result = await getFollowingReelUseCase.getFollowingReel(page.toString());
      result.fold((l) => emit(GetFollowingReelsSucssesState(data: l)), (r) => emit(GetFollowingReelsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

    on<LoadMoreFollowingReelsEvent>((event, emit)async {
      page++ ;
      final result = await getFollowingReelUseCase.getFollowingReel( page.toString());
      result.fold((l) {  if (l != []) {
        emit(
            GetFollowingReelsSucssesState(data: [...state.data!, ...l]));
      }}, (r) => emit(GetFollowingReelsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

  }

}
