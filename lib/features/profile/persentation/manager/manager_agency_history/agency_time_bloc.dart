import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_history_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_state.dart';

class AgencyTimeBloc extends Bloc<BaseAgencyTimeEvent, AgencyTimeState> {
  final AgencyHistoryUsecase agencyHistoryUsecase;
  AgencyTimeBloc({required this.agencyHistoryUsecase})
      : super(AgencyTimeInitial(null)) {
    on<AgencyHistoryEvent>((event, emit) async {
      emit(AgencyTimeLoadingState(null));
      final result = await agencyHistoryUsecase.agencyHistory(
          month: event.mounth, year: event.year);
      result.fold(
          (l) => emit(AgencyTimeSucssesState(data: l)),
          (r) => emit(
              AgencyTimeErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

    on<LoadMoreAgencyHistoryEvent>((event, emit) async {
      final result = await agencyHistoryUsecase.agencyHistory(
          month: event.mounth, year: event.year, page: event.page);

      result.fold((l) {
        l.users = state.data!.users! + l.users!;
        emit(AgencyTimeSucssesState(data: l));
      },
          (r) => emit(
              AgencyTimeErrorState(null, DioHelper().getTypeOfFailure(r))));
    });
  }
}
