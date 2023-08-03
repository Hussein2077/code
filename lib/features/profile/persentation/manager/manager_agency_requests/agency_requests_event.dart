
import 'package:equatable/equatable.dart';

abstract class BaseAgencyRequestsEvent extends Equatable {
  const BaseAgencyRequestsEvent();

  @override
  List<Object> get props => [];
}

class AgencyRequestsEvent extends BaseAgencyRequestsEvent{}