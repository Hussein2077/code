

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_reel_comments_uc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_state.dart';

import '../../../../../core/utils/api_healper/dio_healper.dart';

class GetReelCommentsBloc extends Bloc<BaseGetReelsCommentsEvent, GetReelsCommentsState> {
    final GetReelCommentUseCase getReelCommentUseCase ; 
  int page = 1 ; 
  GetReelCommentsBloc({required this.getReelCommentUseCase}) : super(GetReelsCommentsInitial(null)) {
    on<GetReelsCommentsEvent>((event, emit) async{
        page = 1 ; 
    emit(GetReelsCommentsLoadingState(null));
    final result = await getReelCommentUseCase.getReelComment("1" ,event.reelId );
    result.fold((l) => emit(GetReelsCommentsSucssesState(data: l)), (r) => emit(GetReelsCommentsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

            on<LoadMoreReelsCommentsEvent>((event, emit)async {
          page++ ; 
    final result = await getReelCommentUseCase.getReelComment(page.toString() , event.reelId);
    result.fold((l) {  if (l != []) {
          emit(
              GetReelsCommentsSucssesState(data: [...state.data!, ...l]));
        }}, (r) => emit(GetReelsCommentsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

  }
}
