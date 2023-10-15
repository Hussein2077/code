

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_comment_usecase.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_state.dart';



class GetMomentCommentBloc extends Bloc<BaseGetMomentCommentEvent, GetMomentCommentState> {
   final GetMomentCommentUseCase getMomentCommentUseCase ; 
  int page = 1 ; 
  GetMomentCommentBloc({required this.getMomentCommentUseCase}) : super(GetMomentCommentInitial(null)) {
    on<GetMomentCommentEvent>((event, emit)async {
      page = 1 ; 
    emit(GetMomentCommentLoadingState(null));
    final result = await getMomentCommentUseCase.call(GetMomentCommentPrameter(momentId: event.momentId , page: page.toString()));
    result.fold((l) => emit(GetMomentCommentSucssesState(data: l)), (r) => emit(GetMomentCommentErrorState(null, DioHelper().getTypeOfFailure(r))));
    });


        on<LoadMoreMomentCommentEvent>((event, emit)async {
          page++ ; 
    final result = await getMomentCommentUseCase.call(GetMomentCommentPrameter(momentId: event.momentId , page: page.toString()));
    result.fold((l) {  if (l != []) {
          emit(
              GetMomentCommentSucssesState(data: [...state.data!, ...l]));
        }}, (r) => emit(GetMomentCommentErrorState(null, DioHelper().getTypeOfFailure(r))));
    });



    on<LocalDeleteCommentEvent>((event, emit) async {
      state.data!.removeWhere((element) {
        return element.commentId.toString() == event.commentId.toString();
      });
      emit(GetMomentCommentSucssesState(data: state.data));
    });


  }

}
