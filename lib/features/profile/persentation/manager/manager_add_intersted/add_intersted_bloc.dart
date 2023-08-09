import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/add_intrested_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_state.dart';


class AddInterstedBloc extends Bloc<BaseAddInterstedEvent, AddInterstedState> {
  final AddInterstedUsecase addInterstedUsecase;
  AddInterstedBloc({required this.addInterstedUsecase})
      : super(AddInterstedInitial()) {
    on<AddInterstedEvent>((event, emit) async {
      emit(AddInterstedLoadingState());
      final result = await addInterstedUsecase.addIntrested(event.ids);
      result.fold(
          (l) => emit(AddInterstedSucssesState(message: l)),
          (r) => emit(
              AddInterstedErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
