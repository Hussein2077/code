
import 'package:equatable/equatable.dart';

abstract class ReportRealsEvent extends Equatable {

  const ReportRealsEvent();
}

class ReportReals extends ReportRealsEvent {
  final String reportedId;
  final String description;
  final String realId;

  const ReportReals({
    required this.reportedId,
    required this.description,
    required this.realId,
  });

  @override
  List<Object> get props => [reportedId, description, realId];

}
