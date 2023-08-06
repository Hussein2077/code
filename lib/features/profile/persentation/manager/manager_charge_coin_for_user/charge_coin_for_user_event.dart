
import 'package:equatable/equatable.dart';

abstract class BaseChargeCoinForUserEvent extends Equatable {
  const BaseChargeCoinForUserEvent();

  @override
  List<Object> get props => [];
}

class ChargeCoinForUserEvent extends BaseChargeCoinForUserEvent{
  final String id ; 
  final String amount ;
  const ChargeCoinForUserEvent({required this.amount , required this.id });
}
