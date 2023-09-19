import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/report_reals_use_case.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_state.dart';


class ReportRealsBloc extends Bloc<ReportRealsEvent, ReportRealsState> {
  ReportRealsUseCases reportRealsUseCases ;

  ReportRealsBloc({required this.reportRealsUseCases}) : super(ReportRealsInitial()) {
    on<ReportReals>((event, emit)async {
      emit (ReportReelsLoadingState());
      final result = await reportRealsUseCases.reportReals(ReportRealsParameter(
          realId: event.realId,
          description: event.description,
        reportedId: event.reportedId
      ));
      result.fold((l) => emit(ReportReelsSucssesState(message: l)), (r) => emit(ReportReelsErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
