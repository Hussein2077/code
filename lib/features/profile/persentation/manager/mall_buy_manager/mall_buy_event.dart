
import 'package:equatable/equatable.dart';

abstract class MallBuyEvent extends Equatable {
  const MallBuyEvent();

  @override
  List<Object> get props => [];
}
class BuyItemEvent extends MallBuyEvent {
  final String idItem;
  final String quantity;
  const BuyItemEvent({required this.idItem, required this.quantity});
}