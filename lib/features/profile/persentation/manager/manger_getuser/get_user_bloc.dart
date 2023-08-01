


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_data_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_state.dart';

class GetUserBloc extends Bloc<BaseGetUserEvent, GetUserState> {
  final GetUserDataUseCase getUserDataUseCase;
  GetUserBloc({required this.getUserDataUseCase}) : super(GetUserInitial()) {
    on<GetuserEvent>((event, emit) async {
      emit(GetUserLoddingState());
      final result = await getUserDataUseCase.getUserData(event.userId);
      result.fold((l) => emit(GetUserSucssesState(data: l)),
          (r) => emit(GetUserErorrState(error: DioHelper().getTypeOfFailure(r))));
    });

    on<InituserEvent>((event, emit) async {
      emit(GetUserInitial());
    });
  }
}
