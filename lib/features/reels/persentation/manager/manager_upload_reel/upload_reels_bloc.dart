

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';

import 'upload_reels_event.dart';
import 'upload_reels_state.dart';

class UploadReelsBloc extends Bloc<BaseUploadReelsEvent, UploadReelsState> {
  final UploadReelUseCase uploadReelUseCase ; 
  UploadReelsBloc({required this.uploadReelUseCase ,}) : super(UploadReelsInitial()) {
    on<UploadReelsEvent>((event, emit)async {
      emit (UploadReelsLoadingState());
      final result = await uploadReelUseCase.uploadReel(UploadReelParamiter(reel: event.reel, description: event.description));
      result.fold((l) => emit(UploadReelsSucssesState(message: l)), (r) => emit(UploadReelsErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
