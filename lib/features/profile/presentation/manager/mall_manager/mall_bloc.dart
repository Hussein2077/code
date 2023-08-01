

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_data_use_case.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/mall_manager/mall_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/mall_manager/mall_state.dart';

class MallBloc extends Bloc<MallEvent, GetDataMallStates> {
   final GatDataMallUseCase gatDataUseCase ;

  MallBloc( { required this.gatDataUseCase}): super(const GetDataMallStates()){

    on<GetCarMallEvent>(getCareMall);
    on<GetFramesMallEvent>(getFrames);
    on<GetBubbleMallEvent>(getBubble);

  }





  FutureOr<void> getCareMall(GetCarMallEvent event, Emitter<GetDataMallStates> emit) async{
    final result = await gatDataUseCase.call(event.type);
    result.fold(
            (l) => emit(state.copyWith(carsMall: l,carMallRequest: RequestState.loaded)),
            (r) => emit(state.copyWith(carMallRequest: RequestState.error, carMallMessage: DioHelper().getTypeOfFailure(r)))
    );
  }

  FutureOr<void> getFrames(GetFramesMallEvent event, Emitter<GetDataMallStates> emit)async {
    final result = await gatDataUseCase.call(event.type);
    result.fold(
            (l) => emit(state.copyWith( framesMall:  l,  frameMallRequest: RequestState.loaded)),
            (r) => emit(state.copyWith(frameMallRequest: RequestState.error, frameMallMessage: DioHelper().getTypeOfFailure(r)))
    );

  }

  FutureOr<void> getBubble(GetBubbleMallEvent event, Emitter<GetDataMallStates> emit) async{
    final result = await gatDataUseCase.call(event.type);
    result.fold(
            (l) => emit(state.copyWith(bubblesMall: l,bubbleMallRequest: RequestState.loaded)),
            (r) => emit(state.copyWith(bubbleMallRequest: RequestState.error, bubbleMallMessage: DioHelper().getTypeOfFailure(r)))
    );
  }
}