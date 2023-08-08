
import 'package:equatable/equatable.dart';

abstract class BaseAgencyTimeEvent extends Equatable {
  const BaseAgencyTimeEvent();

  @override
  List<Object> get props => [];
}

class AgencyHistoryEvent extends BaseAgencyTimeEvent{
  final String mounth ;
  final String year ; 
  const  AgencyHistoryEvent ({required this.mounth , required this.year});
}

class LoadMoreAgencyHistoryEvent extends BaseAgencyTimeEvent{
  final String mounth ;
  final String year ; 
  final String page; 

  const  LoadMoreAgencyHistoryEvent ({required this.page ,  required this.mounth , required this.year});
}