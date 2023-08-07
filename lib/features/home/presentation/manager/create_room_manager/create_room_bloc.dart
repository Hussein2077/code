
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/creat_room_usecase.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_states.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvents,CreateRoomStates>{

  final CreateRoomUsecase createRoomUsecase ;
  CreateRoomBloc({required this.createRoomUsecase}):super(InitialRoomStates()){

    on<CreateAudioRoomEvent>(createRoom);

  }


  FutureOr<void> createRoom(CreateAudioRoomEvent event, Emitter<CreateRoomStates> emit)async {
    emit(CreateAudioRoomLoadingState());
    final result = await createRoomUsecase.createRoom(creatRoomPramiter: CreateRoomPramiter(
        roomCover: event.roomCover,
        roomType:event.roomType,
        roomIntero:event.roomIntero,
        roomName: event.roomName
    ));
    result.fold(
            (l) =>emit( CreateAudioRoomErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(l)) ),
            (r) => emit( CreateAudioRoomSuccesMessageState(roomData: r)));
  }


}