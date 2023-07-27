

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_ranking_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_state.dart';

class FamilyRankingBloc extends Bloc<FamilyRankingEvent, FamilyRankingStates> {
  FamilyRankingUsecase familyRankingUsecase;
  FamilyRankingBloc({required this.familyRankingUsecase})
      : super(const FamilyRankingStates()) {
    on<GetFamilyRankingDailyEvent>(getFamilyRankingDaily);
    on<GetFamilyRankingWeekEvent>(getFamilyRankingWeekly);
    on<GetFamilyRankingMonthEvent>(getFamilyRankingMonthly);
  }

  FutureOr<void> getFamilyRankingDaily(GetFamilyRankingDailyEvent event,
      Emitter<FamilyRankingStates> emit) async {
    final result = await familyRankingUsecase.familyRanking(event.time);
    result.fold(
        (l) => emit(state.copyWith(
            dailyData: l, dailyDataRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            dailyDataRequest: RequestState.error,
            dailyDatakMassage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getFamilyRankingWeekly(GetFamilyRankingWeekEvent event,
      Emitter<FamilyRankingStates> emit) async {
    final result = await familyRankingUsecase.familyRanking(event.time);
    result.fold(
        (l) => emit(
            state.copyWith(weekData: l, weekDataRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            weekDataRequest: RequestState.error,
            weekDatakMassage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getFamilyRankingMonthly(GetFamilyRankingMonthEvent event,
      Emitter<FamilyRankingStates> emit) async {
    final result = await familyRankingUsecase.familyRanking(event.time);
    result.fold(
        (l) => emit(state.copyWith(
            monthData: l, monthDataRequest: RequestState.loaded)),
        (r) => emit(state.copyWith(
            monthDataRequest: RequestState.error,
            monthDatakMassage: DioHelper().getTypeOfFailure(r))));
  }
}