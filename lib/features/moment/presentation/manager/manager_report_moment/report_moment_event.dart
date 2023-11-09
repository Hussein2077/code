import 'package:equatable/equatable.dart';

abstract class BaseReportMomentEvent extends Equatable {
  const BaseReportMomentEvent();

  @override
  List<Object> get props => [];
}
class IniitialReportMomentEvent extends BaseReportMomentEvent{}
class ReportMomentEvent extends BaseReportMomentEvent {

  final String momentId;
  final String discreption;
  final String type;

  const ReportMomentEvent( {
    required this.momentId,
    required this.discreption,
    required this.type,

  });
}