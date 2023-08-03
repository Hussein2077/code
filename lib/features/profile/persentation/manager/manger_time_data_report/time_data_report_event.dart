

import 'package:equatable/equatable.dart';

abstract class TimeDataReportEvent extends Equatable {
  const TimeDataReportEvent();

  @override
  List<Object> get props => [];
}


class TimeDataReportToday extends TimeDataReportEvent {

 final String today;
 final String userId ;

 const TimeDataReportToday({required this.today , required this.userId});
}

class TimeDataReportMonth extends TimeDataReportEvent {

 final String month;
  final String userId ;


 const TimeDataReportMonth({required this.month , required this.userId});
}

class TimeDataReportAllInformation extends TimeDataReportEvent {

 final String allInformation;
  final String userId ;


 const TimeDataReportAllInformation({required this.allInformation,required this.userId});
}


