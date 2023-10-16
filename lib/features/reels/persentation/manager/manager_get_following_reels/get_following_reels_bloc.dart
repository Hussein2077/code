import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_following_reels_uc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_state.dart';

class GetFollowingReelsBloc extends Bloc<BaseGetFollowingReelsEvent, GetFollowingReelsState> {
  final GetFollowingReelUseCase getFollowingReelUseCase ;

  GetFollowingReelsBloc({required this.getFollowingReelUseCase}) : super(GetFollowingReelsInitial(null)) {
    on<GetFollowingReelsEvent>((event, emit)async {
      emit(GetFollowingReelsLoadingState(null));
      final result = await getFollowingReelUseCase.getFollowingReel();
      result.fold((l) => emit(GetFollowingReelsSucssesState(data: l)), (r) => emit(GetFollowingReelsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });
  }
}
