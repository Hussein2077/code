import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_all_intersted_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_state.dart';

class GetAllInterstedBloc
    extends Bloc<BaseGetAllInterstedEvent, GetAllInterstedState> {
  final GetAllIntrestedUseCase getAllIntrestedUseCase;
  GetAllInterstedBloc({required this.getAllIntrestedUseCase})
      : super(GetAllInterstedInitial()) {
    on<GetAllInterstedEvent>((event, emit) async {
      emit(GetAllInterstedLoadingState());
      final result = await getAllIntrestedUseCase.getAllIntersted();
      result.fold(
          (l) => emit(GetAllInterstedSucssesState(data: l)),
          (r) => emit(GetAllInterstedErrorState(
              error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
