

import 'package:equatable/equatable.dart';

abstract class FamilyRankingEvent extends Equatable {
  const FamilyRankingEvent();

  @override
  List<Object> get props => [];
}

class GetFamilyRankingDailyEvent extends FamilyRankingEvent {
  final String time;
  const GetFamilyRankingDailyEvent({required this.time});
}

class GetFamilyRankingWeekEvent extends FamilyRankingEvent {
  final String time;
  const GetFamilyRankingWeekEvent({required this.time});
}

class GetFamilyRankingMonthEvent extends FamilyRankingEvent {
  final String time;
  const GetFamilyRankingMonthEvent({required this.time});
}
