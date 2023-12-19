import 'package:equatable/equatable.dart';

class TimeDataReport extends Equatable {
  final int diamonds;
  final int days;
  final String hours;
  final bool today;
  final RealsMoment reals;
  final RealsMoment moment;

  const TimeDataReport({
    required this.diamonds,
    required this.days,
    required this.hours,
    required this.today,
    required this.reals,
    required this.moment,
  });

  TimeDataReport copyWith({
    int? diamonds,
    int? days,
    String? hours,
    bool? today,
    RealsMoment? reals,
    RealsMoment? moment,
  }) {
    return TimeDataReport(
      diamonds: diamonds ?? this.diamonds,
      days: days ?? this.days,
      hours: hours ?? this.hours,
      today: today ?? this.today,
      reals: reals ?? this.reals,
      moment: moment ?? this.moment,
    );
  }

  factory TimeDataReport.fromJason(Map<String, dynamic> jason) {
    return TimeDataReport(
      days: jason['days'],
      diamonds: jason['diamonds'],
      hours: jason['hours'],
      today: jason['today'],
      reals: RealsMoment.fromJason(jason['user_extras']['reals']),
      moment: RealsMoment.fromJason(jason['user_extras']['moments']),
    );
  }

  @override
  List<Object> get props => [
        diamonds,
        days,
        hours,
        reals,
        moment,
        today,
      ];
}

class RealsMoment {
  final int upload;
  final int like;
  final int comment;

  RealsMoment({required this.upload, required this.like, required this.comment});

  factory RealsMoment.fromJason(Map<String, dynamic> jason) {
    return RealsMoment(
      upload: jason['upload'],
      like: jason['like'],
      comment: jason['comment'],
    );
  }

  @override
  List<Object> get props => [
        upload,
        like,
    comment,
      ];
}
