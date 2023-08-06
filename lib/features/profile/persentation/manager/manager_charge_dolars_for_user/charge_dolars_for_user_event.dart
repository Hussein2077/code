
import 'package:equatable/equatable.dart';

abstract class BaseChargeDolarsForUserEvent extends Equatable {
  const BaseChargeDolarsForUserEvent();

  @override
  List<Object> get props => [];
}

class ChargeDolarsForUserEvent extends BaseChargeDolarsForUserEvent{
    final String id ; 
  final String amount ;
  const ChargeDolarsForUserEvent({required this.amount , required this.id });

}