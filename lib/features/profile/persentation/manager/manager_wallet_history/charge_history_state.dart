import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';

abstract class ChargeHistoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChargeHistoryInitial extends ChargeHistoryState {

}

class ChargeHistoryLoadingSentState extends ChargeHistoryState {}

class ChargeHistoryLoadingReceived extends ChargeHistoryState {}

class ChargeHistoryErrorReceivedState extends ChargeHistoryState {
  final String error;
  ChargeHistoryErrorReceivedState({required this.error});
}

class ChargeHistoryErrorSentState extends ChargeHistoryState {
  final String error;
  ChargeHistoryErrorSentState({required this.error});
}


class ChargeHistorySuccessSentState extends ChargeHistoryState {
  final ChargeHistoryModel sent;
  ChargeHistorySuccessSentState({required this.sent});

}class ChargeHistorySuccessReceivedState extends ChargeHistoryState {
  final ChargeHistoryModel received;
  ChargeHistorySuccessReceivedState({required this.received});
}
