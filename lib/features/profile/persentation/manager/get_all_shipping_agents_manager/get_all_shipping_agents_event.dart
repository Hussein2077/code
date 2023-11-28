
import 'package:equatable/equatable.dart';

abstract class AllShippingAgentsEvent extends Equatable {
  const AllShippingAgentsEvent();

  @override
  List<Object> get props => [];
}


class GetAllShippingAgentsEvents extends AllShippingAgentsEvent {}


class GetMoreShippingAgentsEvents extends AllShippingAgentsEvent {}



