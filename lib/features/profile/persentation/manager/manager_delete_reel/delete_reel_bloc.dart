

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delete_reel_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_state.dart';

class DeleteReelBloc extends Bloc<BasseDeleteReelEvent, DeleteReelState> {
  final DeleteReelUseCse deleteReelUseCse ; 
  DeleteReelBloc({required this.deleteReelUseCse}) : super(DeleteReelInitial()) {
    on<DeleteReelEvent>((event, emit)async {
      emit(DeleteReelLodingState());
      final result = await deleteReelUseCse.deleteReel(event.id);
       result.fold((l) => emit(DeleteReelSucssesState(message: l)), (r) => emit(DeleteReelErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
