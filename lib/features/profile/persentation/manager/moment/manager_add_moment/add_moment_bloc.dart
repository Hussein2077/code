

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/moment_usecse/add_moment_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_add_moment/add_moment_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_add_moment/add_moment_state.dart';


class AddMomentBloc extends Bloc<BaseAddMomentEvent, AddMomentState> {
  final AddMomentUseCase addMomentUseCase ; 
  AddMomentBloc({required this.addMomentUseCase}) : super(AddMomentInitial()) {
    on<AddMomentEvent>((event, emit) async{
      emit(AddMomentLoadingState());
      final result = await addMomentUseCase.call(AddMomentPrameter(moment: event.moment, userId: event.userId));
      result.fold((l) => emit(AddMomentSucssesState(message: l)), (r) => emit(AddMomentErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
