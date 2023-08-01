

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/remove_user_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_state.dart';



class FamilyRemoveUserBloc
    extends Bloc<BaseFamilyRemoveUserEvent, FamilyRemoveUserState> {
  RemoveUserFromFamilyUsecase removeUserFromFamilyUsecase;
  FamilyRemoveUserBloc({required this.removeUserFromFamilyUsecase})
      : super(FamilyRemoveUserInitial()) {
    on<removerFamilyUser>((event, emit) async {
      emit(FamilyRemoveUserLoadingState());
      final result = await removeUserFromFamilyUsecase.removeUser(
          event.uId, event.familyId);

      result.fold(
          (l) => emit(FamilyRemoveUserSucssesState(massage: l)),
          (r) => emit(FamilyRemoveUserErrorState(
              error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
