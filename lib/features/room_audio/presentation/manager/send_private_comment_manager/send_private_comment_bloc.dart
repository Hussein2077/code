import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_private_comment_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_private_comment_manager/send_private_comment_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_private_comment_manager/send_private_comment_states.dart';

class SendPrivateCommentBloc extends Bloc<SendPrivateCommentEvents, SendPrivateCommentStates> {
  final SendPrivateCommentUC sendPrivateCommentUC ;

  SendPrivateCommentBloc({
        required this.sendPrivateCommentUC,
      }) : super(SendPrivateCommentInitialState()) {

    on<SnedPrivateComment>(((event, emit) async {
      emit(SendPrivateCommentLoadinglState());
      final result = await sendPrivateCommentUC.sendPrivateComment(message: event.message, userId: event.userId, roomId: event.roomId) ;
      result.fold(
              (l) => emit(SendPrivateCommentSucssesState(l)),
              (r) => emit(SendPrivateCommentErrorState(DioHelper().getTypeOfFailure(r)))
      );
    }));

  }
}
