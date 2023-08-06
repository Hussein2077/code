
import 'package:equatable/equatable.dart';

abstract class BaseAgencyTimeEvent extends Equatable {
  const BaseAgencyTimeEvent();

  @override
  List<Object> get props => [];
}

class AgencyTimeEvent extends BaseAgencyTimeEvent{
  final String mounth ;
  final String year ; 
  const  AgencyTimeEvent ({required this.mounth , required this.year});
}