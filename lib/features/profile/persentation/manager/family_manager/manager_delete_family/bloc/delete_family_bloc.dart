
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delet_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_state.dart';

class DeleteFamilyBloc extends Bloc<DeleteFamilyEvent, DeleteFamilyState> {
  DeleteFamilyUseCse deleteFamilyUseCse;
  DeleteFamilyBloc({required this.deleteFamilyUseCse})
      : super(DeleteFamilyInitial()) {
    on<DeleteFamilyEvent>((event, emit) async {
      emit(DeleteFamilyInitial());
      final result = await deleteFamilyUseCse.deleteFamily(event.id);

      result.fold(
          (l) => emit(DeleteFamilySucssesStete(
                massage: l,
              )),
          (r) => emit(
              DeleteFamilyErrorSate(massage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
