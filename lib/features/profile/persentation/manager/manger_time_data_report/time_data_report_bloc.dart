import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/time_data_report_uc.dart';

import 'time_data_report_event.dart';
import 'time_data_report_state.dart';


class TimeDataReportBloc extends Bloc<TimeDataReportEvent, TimeDataReportState> {
  TimeDataReportUseCases timeDataReportUseCases;

  TimeDataReportBloc({required this.timeDataReportUseCases})
      : super(const TimeDataReportState()) {
    on<TimeDataReportToday>(today);
    on<TimeDataReportMonth>(month);
    on<TimeDataReportAllInformation>(allInfo);
  }

  FutureOr<void> today(TimeDataReportToday event, Emitter<TimeDataReportState> emit)async {


    final result = await timeDataReportUseCases.call(event.today);

    result.fold((l) => emit(state.copyWith(
      dataToday: l,dataTodayReportRequest: RequestState.loaded
    )),
            (r) => emit(state.copyWith(
              dataTodayReportRequest: RequestState.error,
              enteringDataTodayMassage: DioHelper().getTypeOfFailure(r)
            )));

  }

  FutureOr<void> month(TimeDataReportMonth event, Emitter<TimeDataReportState> emit)async {


    final result = await timeDataReportUseCases.call(event.month);

    result.fold((l) => emit(state.copyWith(
        dataMonthly: l,dataMonthlyReportRequest: RequestState.loaded
    )),
            (r) => emit(state.copyWith(
            dataMonthlyReportRequest: RequestState.error,
            enteringDataMonthlyMassage: DioHelper().getTypeOfFailure(r)
        )));
  }

  FutureOr<void> allInfo(TimeDataReportAllInformation event, Emitter<TimeDataReportState> emit)async {


    final result = await timeDataReportUseCases.call(event.allInformation);

    result.fold((l) => emit(state.copyWith(
        allInfoData: l,allInfoDataRequest: RequestState.loaded
    )),
            (r) => emit(state.copyWith(
            allInfoDataRequest: RequestState.error,
            enteringAllInfoDataMassage: DioHelper().getTypeOfFailure(r)
        )));

  }
}
