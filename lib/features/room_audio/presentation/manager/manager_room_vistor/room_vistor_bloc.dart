





import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_room_vistor/room_vistor_event.dart';

import 'room_vistor_state.dart';


class RoomVistorBloc
    extends Bloc<RoomVistorEvent, RoomVistorState> {
      int page = 1 ; 
  final GetAllRoomUserUseCase getAllRoomUserUseCase;
  bool isLoadingMore = false;
  RoomVistorBloc({required this.getAllRoomUserUseCase})
      : super(GetRoomVistorInitialState(null)) {
    on<GetAllRoomUserEvents>((event, emit) async {
      page = 1 ; 
      emit(GetRoomVistorLoadinglState(null));
      final result = await getAllRoomUserUseCase.getAllRoomUser(
          GetAlluserPram(event.ownerId, page.toString(), event.usersIds));

      result.fold((l) {
        emit(GetRoomVistorSucssesState(
          data: l,
         
        ));
      }, (r) {
        emit(GetRoomVistorErrorState( null , DioHelper().getTypeOfFailure(r)));
      });
    });
    on<GetMoreRoomUserEvents>((event, emit) async {
      page++;
      isLoadingMore = true;
      emit(GetRoomVistorSucssesState(data: [
        ...state.data!,
      ]));

      var result = await getAllRoomUserUseCase.getAllRoomUser(
          GetAlluserPram(event.ownerId, page.toString(), null));
      result.fold((l) {
          isLoadingMore = false;

        if (l != []) {
          emit(
              GetRoomVistorSucssesState(data: [...state.data!, ...l]));
        }
       ;
      }, (r) {
         isLoadingMore = false;
        emit(GetRoomVistorErrorState(
            null, DioHelper().getTypeOfFailure(r)));
      
      });
    });
  }
}
