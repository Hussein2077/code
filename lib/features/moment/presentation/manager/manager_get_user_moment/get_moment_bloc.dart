

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_state.dart';



class GetMomentuserBloc extends Bloc<BaseGetMomentEvent, GetMomentUserState> {
  final GetMomentUseCase getMomentUseCase ;
  int page = 1 ;
  GetMomentuserBloc({required this.getMomentUseCase}) : super(GetMomentUserInitial(null)) {
    on<GetUserMomentEvent>((event, emit)async {
      page = 1 ;
      emit(GetMomentUserLoadingState(null));
      final result = await getMomentUseCase.call(GetMomentPrameter(type:"1"  , page: page.toString() , userId: event.userId));
      result.fold((l) => emit(GetMomentUserSucssesState(data: l)), (r) => emit(GetMomentUserErrorState(null, DioHelper().getTypeOfFailure(r))));
    });


    on<LoadMoreUserMomentEvent>((event, emit)async {
      page++ ;
      final result = await getMomentUseCase.call(GetMomentPrameter(type:"1"  , page: page.toString() , userId: event.userId));
      result.fold((l) {  if (l != []) {
        emit(
            GetMomentUserSucssesState(data: [...state.data!, ...l]));
      }}, (r) => emit(GetMomentUserErrorState(null, DioHelper().getTypeOfFailure(r))));
    });
  }

}
