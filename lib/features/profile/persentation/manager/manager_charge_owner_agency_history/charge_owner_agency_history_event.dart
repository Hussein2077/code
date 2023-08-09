abstract class ChargeOwnerAgencyHistoryEvent {}

class ChargeSentHistory extends ChargeOwnerAgencyHistoryEvent{
  final String sent ;
  ChargeSentHistory({ required this.sent,});
}


class ChargeRecivedHistory extends ChargeOwnerAgencyHistoryEvent{
  final String recived ;
  ChargeRecivedHistory({ required this.recived,});
}