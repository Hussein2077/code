import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_top_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_top_inroom/topin_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_top_inroom/topin_room_states.dart';



class TobinRoomBloc extends Bloc<TopInRoonEvents,GetTopInRoomState> {
  final GetTopRoomUC getTopRoomUC;

  TobinRoomBloc({required this.getTopRoomUC}) : super(const GetTopInRoomState()) {
    on<getTopIn24HoursRoomEvent>(getTodayTop);
    on<getTopInTotalRoomEvent>(getTotalTop);
  }


  FutureOr<void> getTodayTop(getTopIn24HoursRoomEvent event,
      Emitter<GetTopInRoomState> emit) async {
    final result = await getTopRoomUC.call(
        TopPramiterInRoom(
            date: event.typeDate, roomId: event.ownerId));
    result.fold(
            (l) =>
            emit(state.copyWith(
                todayUserTopModel: l, todayState: RequestState.loaded)),
            (r) =>
            emit(state.copyWith(
                todayErrorMassage: DioHelper().getTypeOfFailure(r),
                todayState: RequestState.error)));
  }

  FutureOr<void> getTotalTop(getTopInTotalRoomEvent event,
      Emitter<GetTopInRoomState> emit) async {
    final result = await getTopRoomUC.call(
        TopPramiterInRoom(
            date: event.typeDate, roomId: event.ownerId));
    result.fold(
            (l) =>
            emit(state.copyWith(
                totalUserTopModel: l, totalState: RequestState.loaded)),
            (r) =>
            emit(state.copyWith(
                totalErrorMassage: DioHelper().getTypeOfFailure(r),
                totalState: RequestState.error)));
  }


}