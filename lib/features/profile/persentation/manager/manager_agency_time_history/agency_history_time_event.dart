
import 'package:equatable/equatable.dart';

abstract class BaseAgencyHistoryTimeEvent extends Equatable {
  const BaseAgencyHistoryTimeEvent();

  @override
  List<Object> get props => [];
}

class AgencyHistoryTimeEvent extends BaseAgencyHistoryTimeEvent{}