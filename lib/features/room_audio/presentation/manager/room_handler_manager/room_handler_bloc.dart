
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/enter_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/room_handler_manager/room_handler_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/room_handler_manager/room_handler_states.dart';

class RoomHandlerBloc extends Bloc<RoomHandlerEvents,RoomHandlerStates>{

  final EnterRoomUC enterRoomUC ;
  RoomHandlerBloc({
    required this.enterRoomUC}):super(InitialHandlerRoomStates()){

    on<EnterRoomEvent>(enterRoom);
  }




  FutureOr<void> enterRoom(EnterRoomEvent event, Emitter<RoomHandlerStates> emit) async{
    emit( EnterRoomLaoding());
    final result = await enterRoomUC
        .call(EnterRoomPramiter(ownerId: event.ownerId, roomPassword:event.roomPassword,isVip: event.isVip));

    result.fold(
            (l) => emit(EnterRoomSuccesMessageState(room: l )),
            (r) => emit(EnterRoomErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(r)),
        ));
  }
}