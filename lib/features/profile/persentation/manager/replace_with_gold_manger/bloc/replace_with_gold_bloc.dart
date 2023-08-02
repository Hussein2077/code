


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_replace_with_dimond_data.dart';

import 'replace_with_gold_event.dart';
import 'replace_with_gold_state.dart';

class ReplaceWithGoldBloc extends Bloc<BaseReplaceWithGoldEvent, ReplaceWithGoldState> {
  GetReplaceWithGoldUseCase getReplaceWithGoldUseCase ;
  ReplaceWithGoldBloc({required this.getReplaceWithGoldUseCase}) : super(ReplaceWithGoldInitial()) {
    on<ReplaceWithGoldEvent>((event, emit) async{
  emit(ReplaceWithGoldLodingState());
     final result = await getReplaceWithGoldUseCase.getReplaceWithGold();

      result.fold(
          (l) => emit(ReplaceWithGoldSucssesState(
               data: l,
              )),
          (r) =>
              emit(ReplaceWithGoldErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
