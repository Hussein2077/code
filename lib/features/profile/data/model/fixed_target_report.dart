import 'package:equatable/equatable.dart';

class FixedTargetReportModel extends Equatable {
  final String diamonds;
  final String days;
  final int totalDiamond;
  final int totalUsd;
  final String hours;

  const FixedTargetReportModel({
    required this.diamonds,
    required this.days,
    required this.hours,
    required this.totalDiamond,
    required this.totalUsd,
  });

  factory FixedTargetReportModel.fromJason(Map<String, dynamic> jason) {
    return FixedTargetReportModel(
      days: jason['current_total_day'],
      diamonds: jason['diamond'],
      hours: jason['current_total_hour'],
      totalDiamond: jason['total_diamond'],
      totalUsd: jason['total_usd'].toInt(),
    );
  }

  @override
  List<Object> get props => [
        diamonds,
        days,
        hours,
        totalDiamond,
        totalUsd,
      ];
}
