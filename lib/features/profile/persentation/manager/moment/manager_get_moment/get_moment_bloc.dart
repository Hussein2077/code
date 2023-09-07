

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_get_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_get_moment/get_moment_state.dart';

class GetMomentBloc extends Bloc<BaseGetMomentEvent, GetMomentState> {
  final GetMomentUseCase getMomentUseCase ; 
  GetMomentBloc({required this.getMomentUseCase}) : super(GetMomentInitial()) {
    on<GetMomentEvent>((event, emit)async {
      emit (GetMomentLoadingState());
      final result = await getMomentUseCase.call(event.userId);
      result.fold((l) => emit(GetMomentSucssesState(data: l)), (r) => emit(GetMomentErrorState(error: DioHelper().getTypeOfFailure(r))));
      
    });
  }
}
