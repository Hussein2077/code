

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/following/domin/use_case/get_follwers_rooms_uc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_event.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_state.dart';

class GetFollwersRoomBloc extends Bloc<BaseGetFollwersRoomEvent, GetFollwersRoomState> {
  final GetFollwingRoomsUC getFollwingRoomsUC ; 
  GetFollwersRoomBloc({ required this.getFollwingRoomsUC}) : super(GetFollwersRoomInitial()) {
    on<GetFollwersRoomEvent>((event, emit) async{
      emit(GetFollwersRoomLoadingState());
      final result =await getFollwingRoomsUC.call(event.type);
      result.fold((l) => emit(GetFollwersRoomSucssesState(rooms: l)), (r) => DioHelper().getTypeOfFailure(r));

    });
  }
}
