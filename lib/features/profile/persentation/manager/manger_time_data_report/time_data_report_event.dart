

import 'package:equatable/equatable.dart';

abstract class TimeDataReportEvent extends Equatable {
  const TimeDataReportEvent();

  @override
  List<Object> get props => [];
}


class TimeDataReportToday extends TimeDataReportEvent {

 final String today;

 const TimeDataReportToday({required this.today});
}

class TimeDataReportMonth extends TimeDataReportEvent {

 final String month;

 const TimeDataReportMonth({required this.month});
}

class TimeDataReportAllInformation extends TimeDataReportEvent {

 final String allInformation;

 const TimeDataReportAllInformation({required this.allInformation});
}


