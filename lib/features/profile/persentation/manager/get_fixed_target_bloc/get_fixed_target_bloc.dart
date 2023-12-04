import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_fixed_target_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_fixed_target_bloc/get_fixed_target_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_fixed_target_bloc/get_fixed_target_state.dart';

class GetFixedTargetBloc
    extends Bloc<BaseGetFixedTargetEvent, GetFixedTargetStates> {
  final FixedTargetReportUseCase fixedTargetReportUseCase;

  GetFixedTargetBloc({required this.fixedTargetReportUseCase})
      : super(GetFixedTargetInitial(null)) {
    on<GetFixedTargetEvent>((event, emit) async {
      emit(GetFixedTargetLoadingState(null));
      final result = await fixedTargetReportUseCase.call();
      result.fold((l) => emit(GetFixedTargetSucssesState(data: l)),
              (r) => emit(GetFixedTargetErrorState(null, DioHelper().getTypeOfFailure(r))));


    });

  }
}
