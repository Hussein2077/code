

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_history_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_state.dart';

class AgencyTimeBloc extends Bloc<BaseAgencyTimeEvent, AgencyTimeState> {
  final AgencyHistoryUsecase agencyHistoryUsecase;
  AgencyTimeBloc({required this.agencyHistoryUsecase}) : super(AgencyTimeInitial()) {
    on<AgencyTimeEvent>((event, emit)async {
     emit(AgencyTimeLoadingState());
     final result = await agencyHistoryUsecase.agencyHistory(month: event.mounth, year: event.year);
     result.fold((l) => emit(AgencyTimeSucssesState(data: l)), (r) => emit(AgencyTimeErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
