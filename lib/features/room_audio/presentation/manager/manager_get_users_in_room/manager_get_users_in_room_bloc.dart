import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_user_in_room_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_get_users_in_room/manager_get_users_in_room_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_get_users_in_room/manager_get_users_in_room_states.dart';


class GetUsersInRoomBloc extends Bloc<UsersInRoomEvent, UsersInRoomState> {
  final GetRoomUserUseCase getRoomUserUseCase;

  GetUsersInRoomBloc({required this.getRoomUserUseCase}) : super(GetUsersInRoomInitialState(null)) {

    on<GetUsersInRoomEvents>((event, emit) async {
      emit(GetUsersInRoomLoadinglState(null));
      final result = await getRoomUserUseCase.getUsersInRoon(event.userId);
      result.fold((l) {
        emit(GetUsersInRoomSucssesState(data: l,));
      }, (r) {
        emit(GetUsersInRoomErrorState( null , DioHelper().getTypeOfFailure(r)));
      });
    });
  }
}
