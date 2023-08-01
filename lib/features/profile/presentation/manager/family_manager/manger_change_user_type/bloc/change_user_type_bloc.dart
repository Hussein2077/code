

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/change_user_type.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_state.dart';


class ChangeUserTypeBloc
    extends Bloc<BaseChangeUserTypeEvent, ChangeUserTypeState> {
  ChangeUserTypeUsecase changeUserTypeUsecase;
  ChangeUserTypeBloc({required this.changeUserTypeUsecase})
      : super(ChangeUserTypeInitial()) {
    on<ChangeUserTypeEvent>((event, emit) async {
      emit(ChangeUserTypeLoadingState());
      final result = await changeUserTypeUsecase.changeUserType(
          event.userId, event.familyId, event.type);

      result.fold(
          (l) => emit(ChangeUserTypeSucsessState(
                massage: l,
              )),
          (r) => emit(
              ChangeUserTypeErorrState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
