

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_state.dart';

class DeleteReelBloc extends Bloc<BasseDeleteReelEvent, DeleteReelState> {
  DeleteReelBloc() : super(DeleteReelInitial()) {
    on<DeleteReelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
