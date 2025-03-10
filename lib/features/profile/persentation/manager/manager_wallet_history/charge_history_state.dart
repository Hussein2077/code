import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';

// abstract class ChargeHistoryState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ChargeHistoryInitial extends ChargeHistoryState {

// }

// class ChargeHistoryLoadingSentState extends ChargeHistoryState {}

// class ChargeHistoryLoadingReceived extends ChargeHistoryState {}

// class ChargeHistoryErrorReceivedState extends ChargeHistoryState {
//   final String error;
//   ChargeHistoryErrorReceivedState({required this.error});
// }

// class ChargeHistoryErrorSentState extends ChargeHistoryState {
//   final String error;
//   ChargeHistoryErrorSentState({required this.error});
// }


// class ChargeHistorySuccessSentState extends ChargeHistoryState {
//   final ChargeHistoryModel sent;
//   ChargeHistorySuccessSentState({required this.sent});

// }class ChargeHistorySuccessReceivedState extends ChargeHistoryState {
//   final ChargeHistoryModel received;
//   ChargeHistorySuccessReceivedState({required this.received});
// }


class ChargeHistoryState extends Equatable {
   final ChargeHistoryModel? sent;
  final RequestState sentState;
  final String sentMessage;
    final ChargeHistoryModel? recived;
  final RequestState recivedState;
  final String recivedMessage;


  const ChargeHistoryState(
      {this.sentMessage = "",
      this.sent ,
      this.sentState = RequestState.loading,
      this.recivedMessage = "",
      this.recived ,
      this.recivedState = RequestState.loading,
     });

  ChargeHistoryState copyWith({
   ChargeHistoryModel? sent,
    RequestState? sentState,
    String? sentMessage,
    ChargeHistoryModel? recived,
    RequestState? recivedState,
    String? recivedMessage,
   
  }) {
    return ChargeHistoryState(
      sent : sent?? this.sent , 
      recived: recived?? this.recived,
      recivedMessage: recivedMessage??this.recivedMessage,
      sentMessage: sentMessage??this.sentMessage,
      recivedState: recivedState??this.recivedState,
      sentState: sentState??this.sentState,

       );
  }

  @override
  List<Object?> get props => [
        sent,
        recived,
        recivedMessage,
        sentMessage,
        recivedState,
        sentState,
      ];
}