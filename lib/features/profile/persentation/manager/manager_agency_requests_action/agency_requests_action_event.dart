
import 'package:equatable/equatable.dart';

abstract class BaseAgencyRequestsActionEvent extends Equatable {
  const BaseAgencyRequestsActionEvent();

  @override
  List<Object> get props => [];
}
class AgencyRequestsActionEvent extends BaseAgencyRequestsActionEvent{
  final String userId ; 
  final bool accept ; 
  const AgencyRequestsActionEvent({required this.accept , required this.userId});
}