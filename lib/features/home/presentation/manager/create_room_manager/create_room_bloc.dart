
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/creat_room_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_all_room_types_uc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_states.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvents,CreateRoomStates>{

  final CreateRoomUsecase createRoomUsecase ;
  final GetAllRoomTypesUC getAllRoomTypesUC ;
  CreateRoomBloc({required this.createRoomUsecase, required this.getAllRoomTypesUC}):super(const CreateRoomStates()){

    on<CreateAudioRoomEvent>(createRoom);
    on<GetTypesRoomEvent>(getTypeRooms) ;

  }


  FutureOr<void> createRoom(CreateAudioRoomEvent event, Emitter<CreateRoomStates> emit)async {
    final result = await createRoomUsecase.createRoom(creatRoomPramiter: CreateRoomPramiter(
        roomCover: event.roomCover,
        roomType:event.roomType,
        roomPassword: event.password,
        roomIntero:event.roomIntero,
        roomName: event.roomName
    ));
    result.fold(
            (l) => emit( state.copyWith(createRoomErrorMessage:DioHelper().getTypeOfFailure(l),
              createRoomState: RequestState.error ,
            )),
            (r) => emit(state.copyWith(createSuccecRoom: r,createRoomState:RequestState.loaded )));
  }

  FutureOr<void> getTypeRooms(GetTypesRoomEvent event, Emitter<CreateRoomStates> emit)async {
    final result = await getAllRoomTypesUC.call(const Noparamiter());
    result.fold(
            (l) =>emit(state.copyWith(typesRoom:l ,typesRoomState:RequestState.loaded )),
            (r) => emit(state.copyWith(typesErrorMessage:  DioHelper().getTypeOfFailure(r),typesRoomState: RequestState.error))
    );
  }



}