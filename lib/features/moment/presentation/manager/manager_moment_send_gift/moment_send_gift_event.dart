import 'package:equatable/equatable.dart';

abstract class BaseMomentSendGiftEvent extends Equatable {
  const BaseMomentSendGiftEvent();

  @override
  List<Object> get props => [];
}

class MomentSendGiftEvent extends BaseMomentSendGiftEvent {

final String momentId;
final int giftNum;
final int giftId;
// final MomentSendGiftPrameter momentSendGiftPrameter;
const MomentSendGiftEvent( {
// required this.momentSendGiftPrameter,
required this.momentId,
required this.giftNum,
required this.giftId,
});
}