import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_intersted_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_state.dart';

class GetUserInterstedBloc
    extends Bloc<GetUserInterstedEvent, GetUserInterstedState> {
  final GetUserIntrestedUseCase getUserIntrestedUseCase;
  GetUserInterstedBloc({required this.getUserIntrestedUseCase})
      : super(GetUserInterstedInitial()) {
    on<GetUserInterstedEvent>((event, emit) async {
      emit(GetUserInterstedLoadingState());
      final result = await getUserIntrestedUseCase.getUserIntersted();
      result.fold(
          (l) => emit(GetUserInterstedSucssesState(data: l)),
          (r) => emit(GetUserInterstedErrorState(
              error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
