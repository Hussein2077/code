
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';

class GetDataMallStates extends Equatable {
  final List<DataMallEntities> carsMall;
  final RequestState carMallRequest;
  final String carMallMessage;
  final List<DataMallEntities> framesMall;
  final RequestState frameMallRequest;
  final String frameMallMessage;
  final List<DataMallEntities> bubblesMall;
  final RequestState bubbleMallRequest;
  final String bubbleMallMessage;

  const GetDataMallStates(
      {this.carsMall = const [],
      this.carMallRequest = RequestState.loading,
      this.carMallMessage = "",
      this.framesMall = const [],
      this.frameMallRequest = RequestState.loading,
      this.frameMallMessage = "",
      this.bubblesMall = const [],
      this.bubbleMallRequest = RequestState.loading,
      this.bubbleMallMessage = ""});

  GetDataMallStates copyWith({
    List<DataMallEntities>? carsMall,
    RequestState? carMallRequest,
    String? carMallMessage,
    List<DataMallEntities>? framesMall,
    RequestState? frameMallRequest,
    String? frameMallMessage,
    List<DataMallEntities>? bubblesMall,
    RequestState? bubbleMallRequest,
    String? bubbleMallMessage,
  }) {
    return GetDataMallStates(
        carsMall: carsMall ?? this.carsMall,
        carMallRequest: carMallRequest ?? this.carMallRequest,
        carMallMessage: carMallMessage ?? this.carMallMessage,
        framesMall: framesMall ?? this.framesMall,
        frameMallRequest: frameMallRequest ?? this.frameMallRequest,
        frameMallMessage: frameMallMessage ?? this.frameMallMessage,
        bubblesMall: bubblesMall ?? this.bubblesMall,
        bubbleMallRequest: bubbleMallRequest ?? this.bubbleMallRequest,
        bubbleMallMessage: bubbleMallMessage ?? this.frameMallMessage);
  }

  @override
  List<Object?> get props => [
        carsMall,
        carMallMessage,
        carMallRequest,
        frameMallMessage,
        frameMallRequest,
        framesMall,
        bubblesMall,
        bubbleMallRequest,
        bubbleMallMessage
      ];
}

