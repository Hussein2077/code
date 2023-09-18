
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/moment_usecse/moment_send_gift.dart';

abstract class BaseMomentSendGiftEvent extends Equatable {
  const BaseMomentSendGiftEvent();

  @override
  List<Object> get props => [];
}

class MomentSendGiftEvent extends BaseMomentSendGiftEvent {
  final MomentSendGiftPrameter momentSendGiftPrameter ;
  const MomentSendGiftEvent({required this.momentSendGiftPrameter});
}