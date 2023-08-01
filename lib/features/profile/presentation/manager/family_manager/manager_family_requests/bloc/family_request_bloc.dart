

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_family_request_usecase.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_family_requests/bloc/family_request_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_family_requests/bloc/family_request_state.dart';


class FamilyRequestBloc
    extends Bloc<BaseFamilyRequestEvent, FamilyRequestState> {
  GetFamilyRequestUsecase getFamilyRequestUsecase;
  FamilyRequestBloc({required this.getFamilyRequestUsecase})
      : super(FamilyRequestInitial()) {
    on<GetFamilyRequestEvent>((event, emit) async {
      emit(FamilyRequestLoadingState());
      final result = await getFamilyRequestUsecase.getFamilyRequest();

      result.fold(
          (l) => emit(FamilyRequestSUcsessState(data: l)),
          (r) => emit(
              FamilyRequestErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
