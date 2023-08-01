

import 'package:equatable/equatable.dart';

abstract class GiftHistoryEvent extends Equatable {
  const GiftHistoryEvent();

  @override
  List<Object> get props => [];
}
class GetGiftHistory extends GiftHistoryEvent{
  final String id ; 
  const GetGiftHistory({required this.id });
}
