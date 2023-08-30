import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/make_reel_like_use_case.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_state.dart';

class MakeReelLikeBloc extends Bloc<BaseMakeReelLikeEvent, MakeReelLikeState> {
  MakeReelLikeUseCase makeReelLikeUseCase ;
  MakeReelLikeBloc({required this.makeReelLikeUseCase }) : super(MakeReelLikeInitial()) {
    on<MakeReelLikeEvent>((event, emit) async{
      emit(MakeReelLikeLoadingState());
      final result = await makeReelLikeUseCase.makeReelLike(event.reelId, );
        
        result.fold((l) => emit(MakeReelLikeSucssesState(message: l)), (r) =>emit(MakeReelLikeErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}