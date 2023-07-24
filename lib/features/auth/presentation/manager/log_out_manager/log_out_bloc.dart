





import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/log_out_usecase.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_state.dart';

class LogOutBloc extends Bloc<BaseLogOutEvent, LogOutState> {
  LogOutUseCase logOutUseCase ; 
  LogOutBloc({required this.logOutUseCase ,}) : super(LogOutInitial()) {
    on<LogOutEvent>((event, emit) async{
      emit (LogOutLoadingState());
      final result = await logOutUseCase.call();

      result.fold((l) => emit(LogOutSucssesState()), (r) => emit(LogOutErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
