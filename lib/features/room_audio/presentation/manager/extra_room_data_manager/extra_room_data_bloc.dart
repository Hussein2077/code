import 'package:bloc/bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/extra_room_data_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/extra_room_data_manager/extra_room_data_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/extra_room_data_manager/extra_room_data_state.dart';


class ExtraRoomDataBloc extends Bloc<ExtraRoomDataEvent, ExtraRoomDataState> {

  ExtraRoomDataUseCase extraRoomDataUseCase ;
  ExtraRoomDataBloc({required this.extraRoomDataUseCase}) : super(ExtraRoomDataInitial()) {

    on<GetExtraRoomDataEvent>((event, emit) async{
      emit(ExtraRoomDataloadingState());
      var result = await extraRoomDataUseCase.call(event.OwnerId);
      result.fold((l) => emit(ExtraRoomDataSuccessState(
          data: l
      )), (r) => emit(ExtraRoomDataFilureState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
