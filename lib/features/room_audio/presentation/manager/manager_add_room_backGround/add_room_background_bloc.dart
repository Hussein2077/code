

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/add_room_back_ground_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_state.dart';

class AddRoomBackgroundBloc extends Bloc<BaseAddRoomBackgroundEvent, AddRoomBackgroundState> {
  AddRoomBackGroundUseCase addRoomBackGroundUseCase ; 

  AddRoomBackgroundBloc({required this.addRoomBackGroundUseCase}) : super(AddRoomBackgroundInitial()) {
    on<AddRoomBackgroundEvent>((event, emit)async {
      emit(AddRoomBackgroundLoading());
      final result =await addRoomBackGroundUseCase.call(event.roomBackGround);

       result.fold((l) => emit(AddRoomBackgroundSucsses(massage: l)),
            (r) => emit(AddRoomBackgroundError(error: DioHelper().getTypeOfFailure(r))));
      
    });
  }
}
