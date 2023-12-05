import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/host_time_on_mic_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/host_time_on_mic_bloc/host_on_mic_time_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/host_time_on_mic_bloc/host_on_mic_time_state.dart';



class HostOnMicTimeBloc extends Bloc<BaseHostOnMicTimeEvent, HostOnMicTimeState> {
final HostOnMicTimeUseCase hostOnMicTimeUseCase ;
  HostOnMicTimeBloc({required this.hostOnMicTimeUseCase}) : super(HostOnMicTimeInitial()) {
    on<HostOnMicTimeEvent>((event, emit) async{
      emit(HostOnMicTimeLoading());
      var result = await hostOnMicTimeUseCase.call(event.totalTime);
      result.fold((l) => emit(HostOnMicTimeSucssesState(messsage: l)), (r) => emit(HostOnMicTimeErrorState(messsage: DioHelper().getTypeOfFailure(r))));



    });
  }
}
