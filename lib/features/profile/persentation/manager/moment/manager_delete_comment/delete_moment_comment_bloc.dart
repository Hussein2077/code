

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/moment_usecse/delete_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_delete_comment/delete_moment_comment_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_delete_comment/delete_moment_comment_state.dart';

class DeleteMomentCommentBloc extends Bloc<BaseDeleteMomentCommentEvent, DeleteMomentCommentState> {
  final DeleteMomentCommentUseCase deleteMomentCommentUseCase ; 
  DeleteMomentCommentBloc({required this.deleteMomentCommentUseCase}) : super(DeleteMomentCommentInitial()) {
    on<DeleteMomentCommentEvent>((event, emit) async{
      emit(DeleteMomentCommentLoadingState());
      final result = await deleteMomentCommentUseCase.call(DeleteMomentCommentPrameter(commentId: event.commentId, momentId: event.momentId));
      result.fold((l) => emit(DeleteMomentCommentSucssesState(message: l)), (r) => emit(DeleteMomentCommentErrorState(error: DioHelper().getTypeOfFailure(r))));

     
    });
  }
}
