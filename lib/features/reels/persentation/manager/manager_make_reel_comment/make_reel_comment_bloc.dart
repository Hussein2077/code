



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_state.dart';

import '../../../domin/use_case/make_reel_comment.dart';

class MakeReelCommentBloc extends Bloc<BaseMakeReelCommentEvent, MakeReelCommentState> {
  MakeReelCommentUseCase makeReelCommentUseCase ;
  MakeReelCommentBloc({required this.makeReelCommentUseCase }) : super(MakeReelCommentInitial()) {
    on<MakeReelCommentEvent>((event, emit) async{
      emit(MakeReelCommentLoadingState());
      final result = await makeReelCommentUseCase.makeReelComment(event.reelId, event.comment);
        
        result.fold((l) => emit(MakeReelCommentSucssesState(message: l)), (r) =>emit(MakeReelCommentErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
