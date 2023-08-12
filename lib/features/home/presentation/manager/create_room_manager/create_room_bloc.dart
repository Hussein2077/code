
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/creat_room_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_all_room_types_uc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_states.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvents,CreateRoomStates>{

  final CreateRoomUsecase createRoomUsecase ;
  final GetAllRoomTypesUC getAllRoomTypesUC ;
  CreateRoomBloc({required this.createRoomUsecase, required this.getAllRoomTypesUC}):super(InitialRoomStates()){

    on<CreateAudioRoomEvent>(createRoom);
    on<GetTypesRoomEvent>(getTypeRooms) ;

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

  FutureOr<void> getTypeRooms(GetTypesRoomEvent event, Emitter<CreateRoomStates> emit)async {
    emit(GetTypesRoomLoadingState());
    final result = await getAllRoomTypesUC.call(const Noparamiter()) ;
    result.fold(
            (l) =>emit(  GetTypesRoomSuccesMessageState(typesRoom: l) ),
            (r) => emit( GetTypesRoomErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(r)) ));
  }



}