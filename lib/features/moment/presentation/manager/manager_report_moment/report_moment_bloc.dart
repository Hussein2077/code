import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/report_moment_usecase.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_report_moment/report_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_report_moment/report_moment_state.dart';

class ReportMomentBloc extends Bloc<BaseReportMomentEvent, ReportMomentStates> {
  final ReportMomentUseCase reportMomentUseCase;

  ReportMomentBloc({required this.reportMomentUseCase})
      : super(ReportMomentInitialState()) {
    on<ReportMomentEvent>((event, emit) async {
      emit(ReportMomentLoadingState());
      final result = await reportMomentUseCase.call(
        ReportMomentParam(
            momentId: event.momentId, discreption: event.discreption, type: event.type,

        ),
      );
      result.fold(
              (l) => emit(ReportMomentSucssesState(sucssesMessage: l)),
              (r) {
            log(r.toString());
            emit(ReportMomentErrorState(
                errorMessage: DioHelper().getTypeOfFailure(r)));});
    });
    on<IniitialReportMomentEvent>((event, emit)  {
      emit(ReportMomentInitialState());

    });
  }
}
