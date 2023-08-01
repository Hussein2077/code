


import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/gift_history_model.dart';

abstract class BaseGiftHistoryState extends Equatable {
  const BaseGiftHistoryState();
  
  @override
  List<Object> get props => [];
}

class GiftHistoryInitial extends BaseGiftHistoryState {}
class GiftHistoryLoadingState extends BaseGiftHistoryState {}
class GiftHistorySucssesState extends BaseGiftHistoryState {
 final List<GiftHistoryModel> data ;
const GiftHistorySucssesState({required this.data});
}
class GiftHistoryErrorState extends BaseGiftHistoryState {
  final String error ; 
  const GiftHistoryErrorState({required this.error});
}
