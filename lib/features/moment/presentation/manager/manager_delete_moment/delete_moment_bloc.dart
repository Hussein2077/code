import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/delete_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_state.dart';



class DeleteMomentBloc extends Bloc<BaseDeleteMomentEvent, DeleteMomentState> {
  final DeleteMomentUseCase deleteMomentUseCase;
  DeleteMomentBloc({required this.deleteMomentUseCase})
      : super(DeleteMomentInitial()) {
    on<DeleteMomentEvent>((event, emit) async {
      emit(DeleteMomentLoadingState());
      final result = await deleteMomentUseCase.call(event.momentId);
      result.fold(
          (l) => emit(DeleteMomentSucssesState(message: l)),
          (r) => emit(
              DeleteMomentErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
