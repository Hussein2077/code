import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/chat/domine/usecases/post_group_chat_usecase.dart';

import 'post_group_chat_event.dart';
import 'post_group_chat_state.dart';

class PostGroupChatBloc extends Bloc<BaseGroupChatEvent, GroupChatState> {
  PostGroupMassageUseCase postGroupMassageUseCase;

  PostGroupChatBloc({required this.postGroupMassageUseCase})
      : super(GroupChatInitial()) {
    on<PostGroupChatEvent>((event, emit) async {
      emit(PostGroupChatLoading());
      final result = await postGroupMassageUseCase.call(event.massage);
      result.fold(
          (l) => emit(PostGroupChatSucsses(massage: l)),
          (r) =>
              emit(PostGroupChatError(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
