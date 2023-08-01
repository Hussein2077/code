

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_take_action_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_take_action/bloc/take_action_state.dart';

import 'take_action_event.dart';


class TakeActionBloc extends Bloc<BaseTakeActionEvent, TakeActionState> {
  FamilyTakeActionUsecase familyTakeActionUsecase;
  TakeActionBloc({required this.familyTakeActionUsecase})
      : super(TakeActionInitial()) {
    on<FamilyTakeActionEvent>((event, emit) async {
      emit(FamilyTakeActionLoadingState());
      final result = await familyTakeActionUsecase.familyTakeAction(
          event.reqId, event.status);

      result.fold(
          (l) => emit(FamilyTakeActionSucssesState(massage: l)),
          (r) => emit(FamilyTakeActionErrorState(
              error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
