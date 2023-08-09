abstract class ChargeCoinSystemHistoryEvent {}

class ChargeSentHistory extends ChargeCoinSystemHistoryEvent{
  final String sent ;
  ChargeSentHistory({ required this.sent,});
}


class ChargeRecivedHistory extends ChargeCoinSystemHistoryEvent{
  final String recived ;
  ChargeRecivedHistory({ required this.recived,});
}
