

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/exit_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_exite_family/bloc/exit_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_exite_family/bloc/exit_family_state.dart';


class ExitFamilyBloc extends Bloc<BaseExitFamilyEvent, ExitFamilyState> {
  ExitFamilyUsecase exitFamilyUsecase;
  ExitFamilyBloc({required this.exitFamilyUsecase})
      : super(ExitFamilyInitial()) {
    on<ExitFamilyEvent>((event, emit) async {
      emit(ExitFamilyLoadingState());
      final result = await exitFamilyUsecase.exitFamily();

      result.fold(
          (l) => emit(ExitFamilySucssesState(massage: l)),
          (r) =>
              emit(ExitFamilyErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
