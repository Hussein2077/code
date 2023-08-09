import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';

class ChargeCoinSystemHistoryState extends Equatable {
   final ChargeHistoryModel? sent;
  final RequestState sentState;
  final String sentMessage;
    final ChargeHistoryModel? recived;
  final RequestState recivedState;
  final String recivedMessage;


  const ChargeCoinSystemHistoryState(
      {this.sentMessage = "",
      this.sent ,
      this.sentState = RequestState.loading,
      this.recivedMessage = "",
      this.recived ,
      this.recivedState = RequestState.loading,
     });

  ChargeCoinSystemHistoryState copyWith({
   ChargeHistoryModel? sent,
    RequestState? sentState,
    String? sentMessage,
    ChargeHistoryModel? recived,
    RequestState? recivedState,
    String? recivedMessage,
   
  }) {
    return ChargeCoinSystemHistoryState(
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