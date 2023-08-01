

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/join_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_join_family/bloc/join_family_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_join_family/bloc/join_family_state.dart';


class JoinFamilyBloc extends Bloc<BaseJoinFamilyEvent, JoinFamilyState> {
  JoinFamilymUsecase joinFamilymUsecase;
  JoinFamilyBloc({required this.joinFamilymUsecase})
      : super(JoinFamilyInitial()) {
    on<JoinFamilyEvent>((event, emit) async {
      emit(JoinFamilyLoadingState());

      final result = await joinFamilymUsecase.joinFamily(event.id);

      result.fold(
          (l) => emit(JoinFamilySucssesState(messeage: l)),
          (r) =>
              emit(JoinFamilyErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
    on<InitJoinFamilyEvent>((event, emit) {
      emit(JoinFamilyInitial());
    });
  }
}
