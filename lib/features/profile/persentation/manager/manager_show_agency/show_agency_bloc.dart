

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/show_agnecy_uc.dart';

import 'show_agency_event.dart';
import 'show_agency_state.dart';

class ShowAgencyBloc extends Bloc<BaseShowAgencyEvent, ShowAgencyState> {
  final ShowAgencymUsecase showAgencymUsecase ; 
  ShowAgencyBloc({required this.showAgencymUsecase}) : super(ShowAgencyInitial()) {
    on<ShowAgencyEvent>((event, emit)async {
      emit(ShowAgencyLoadingState());
      final result = await showAgencymUsecase.showAgency();
      result.fold((l) => emit(ShowAgencySucssesState(data: l)), (r) => emit(ShowAgencyErrorState(error: DioHelper().getTypeOfFailure(r))));


    });
  }
}
