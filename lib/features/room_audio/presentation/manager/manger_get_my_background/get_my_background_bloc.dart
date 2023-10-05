

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_mybackground_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_state.dart';

class GetMyBackgroundBloc extends Bloc<BaseGetMyBackgroundEvent, GetMyBackgroundState> {
  GetMyBackGroundUseCase getMyBackGroundUseCase ;
  GetMyBackgroundBloc({required this.getMyBackGroundUseCase}) : super(GetMyBackgroundInitial()) {
    on<GetMyBackGroundEvent>((event, emit)async {

        emit(GetMyBackgroundLodingState());
      final result = await getMyBackGroundUseCase.getMyBackGround();
      result.fold(
          (l) => emit(GetMyBackgroundSucssesState(data: l)),
          (r) => emit(GetMyBackgroundErrorState(
              error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
