




import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/create_family_uc.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manger_create_family/bloc/create_family_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manger_create_family/bloc/create_family_state.dart';

class CreateFamilyBloc extends Bloc<CreateFamilyEvent, CreateFamilyState> {
  CreateFamilyUC createFamilyUC;
  CreateFamilyBloc({required this.createFamilyUC})
      : super(CreateFamilyInitialState()) {
    on<CreateFamilyEvent>((event, emit) async {
      emit(CreateFamilyLoadingState());
      final result = await createFamilyUC.call(CreateFamilyPramiter(
          image: event.image, introduce: event.bio, name: event.name));

      result.fold(
          (l) => emit(CreateFamilySucssesState(
                id: l,
              )),
          (r) => emit(
              CreateFamilyErrorState(massage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
