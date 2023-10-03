

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_state.dart';


class AddMomentCommentBloc extends Bloc<BaseAddMomentCommentEvent, AddMomentCommentState> {
  final AddMomentCommentUseCase addMomentCommentUseCase ; 
  
  AddMomentCommentBloc({required this.addMomentCommentUseCase}) : super(AddMomentCommentInitial()) {
    on<AddMomentCommentEvent>((event, emit) async{
      emit(AddMomentCommentLoadingState());
      final result = await addMomentCommentUseCase.call(AddMomentCommentPrameter(comment: event.comment, momentId: event.momentId));
      result.fold((l) => emit(AddMomentCommentSucssesState(message: l)), (r) => emit(AddMomentCommentErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
