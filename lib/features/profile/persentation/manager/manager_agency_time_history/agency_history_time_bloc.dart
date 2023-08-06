

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_history_time_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_time_history/agency_history_time_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_time_history/agency_history_time_state.dart';

class AgencyHistoryTimeBloc extends Bloc<BaseAgencyHistoryTimeEvent, AgencyHistoryTimeState> {
  final AgencyHistoryTimemUsecase agencyHistoryTimemUsecase ; 
  AgencyHistoryTimeBloc({required this.agencyHistoryTimemUsecase}) : super(AgencyHistoryTimeInitial()) {
    on<AgencyHistoryTimeEvent>((event, emit)async {
      emit (AgencyHistoryTimeLoadingState());
      final result = await agencyHistoryTimemUsecase.agencyHistoryTime();
          
          result.fold((l) => emit(AgencyHistoryTimeSucssesState(data: l)), (r) => emit(AgencyHistoryTimeErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
