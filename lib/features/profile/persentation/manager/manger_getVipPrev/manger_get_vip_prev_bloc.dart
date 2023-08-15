
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/vipPervilage_usecase/get_vip_prev_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_state.dart';



class MangerGetVipPrevBloc extends Bloc<MangerGetVipPrevEvent, MangerGetVipPrevState> {
  GetVipPrevUseCase getVipPrevUseCase ;
  MangerGetVipPrevBloc({required this.getVipPrevUseCase}) : super(MangerGetVipPrevInitial()) {
    on<getVipPrevEvent>((event, emit)async {
       emit(GetVipPrevLoadingState());
      final result = await getVipPrevUseCase.getVipPrevUseCase();

      result.fold(
          (l) => emit(GetVipPrevSucssesState(
                data: l,
              )),
          (r) =>
              emit(GetVipPrevErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
