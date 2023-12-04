import 'package:equatable/equatable.dart';

class FixedTargetReportModel extends Equatable {
  final int diamonds;
  final int days;
  final int momentNum;
  final int reelNum;
  final String hours;

  const FixedTargetReportModel({
    required this.diamonds,
    required this.days,
    required this.hours,
    required this.momentNum,
    required this.reelNum,
  });

  factory FixedTargetReportModel.fromJason(Map<String, dynamic> jason) {
    return FixedTargetReportModel(
      days: jason['days'],
      diamonds: jason['diamonds'],
      hours: jason['hours'],
      momentNum: jason['moment-num'],
      reelNum: jason['reel-num'],
    );
  }

  @override
  List<Object> get props => [
        diamonds,
        days,
        hours,
        momentNum,
        reelNum,
      ];
}
