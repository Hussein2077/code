import 'package:equatable/equatable.dart';

class TimeDataReport extends Equatable {

 final int diamonds;
 final int days;
 final String hours;
 final bool  today;
  const TimeDataReport(
      { required this.diamonds,
       required this.days,
       required this.hours,
       required this.today});

  TimeDataReport copyWith({
   int? diamonds,
   int ?days,
   String? hours,
   bool? today,
}){
    return TimeDataReport(
        diamonds: diamonds ?? this.diamonds,
        days: days ??this.days,
        hours: hours ?? this.hours,
        today: today ?? this.today
    );

}


  factory TimeDataReport.fromJason(Map<String,dynamic>jason){
    return TimeDataReport(
      days: jason['days'],
      diamonds: jason['diamonds'],
      hours: jason['hours'],
      today: jason['today'],
    );
  }

  @override
  List<Object> get props => [
        diamonds,
        days,
        hours,
        today,
      ];
}
