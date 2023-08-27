
import 'package:equatable/equatable.dart';

abstract class GoldCoinEvent extends Equatable {
  const GoldCoinEvent();

  @override
  List<Object> get props => [];
}
class GetGoldCoinDataEvent extends GoldCoinEvent{}

class RechargeCoinsEvent extends  GoldCoinEvent{
  final String  packageCoinId ;

  RechargeCoinsEvent({required this.packageCoinId});
}