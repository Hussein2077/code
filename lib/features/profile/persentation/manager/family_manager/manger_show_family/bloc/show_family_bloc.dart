

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/show_family_usecase.dart';

import 'show_family_event.dart';
import 'show_family_state.dart';


class ShowFamilyBloc extends Bloc<BaseShowFamilyEvent, ShowFamilyState> {
  ShowFamilymUsecase showFamilymUsecase;

  ShowFamilyBloc({required this.showFamilymUsecase})
      : super(ShowFamilyInitial()) {
    on<ShowFamilyEvent>((event, emit) async {
      emit(ShowFamilyLoadingState());

      final result = await showFamilymUsecase.showFmily(event.id);

      result.fold(
          (l) => emit(ShowFamilySucssesState(data: l)),
          (r) =>
              emit(ShowFamilyErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
