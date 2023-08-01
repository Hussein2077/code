
import 'package:equatable/equatable.dart';

abstract class BaseBuyOrSendVipEvent extends Equatable {
  const BaseBuyOrSendVipEvent();

  @override
  List<Object> get props => [];
}

class BuyOrSendVipEvent extends BaseBuyOrSendVipEvent{
  final String type ; 
  final String vipId;
  final String toUId;
  const BuyOrSendVipEvent({required this.type , required this.vipId , required this.toUId});
}
