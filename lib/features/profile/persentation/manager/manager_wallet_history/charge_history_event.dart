


abstract class ChargeHistoryEvent {}

class ChargeHistory extends ChargeHistoryEvent{
  final String sent ;
  ChargeHistory({ required this.sent,});
}