


abstract class ChargeHistoryEvent {}

class ChargeSentHistory extends ChargeHistoryEvent{
  final String sent ;
  ChargeSentHistory({ required this.sent,});
}


class ChargeRecivedHistory extends ChargeHistoryEvent{
  final String recived ;
  ChargeRecivedHistory({ required this.recived,});
}