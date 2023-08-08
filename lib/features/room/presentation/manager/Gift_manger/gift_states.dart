import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room/data/model/gifts_model.dart';




class GiftsStates extends Equatable {
  final List<GiftsModel> dataNormal;
  final RequestState normalState;
  final String normalMessage;
  final List<GiftsModel> dataHot;
  final RequestState hotState;
  final String hotMessage;
  final List<GiftsModel> dataCountry;
  final RequestState countryState;
  final String countryMessage;

  const GiftsStates(
      {this.hotMessage = "",
      this.dataNormal = const [],
      this.normalState = RequestState.loading,
      this.normalMessage = "",
      this.dataHot = const [],
      this.hotState = RequestState.loading,
      this.countryMessage = "",
      this.countryState = RequestState.loading,
      this.dataCountry = const []});

  GiftsStates copyWith({
    List<GiftsModel>? dataNormal,
    RequestState? normalState,
    String? normalMessage,
    List<GiftsModel>? dataHot,
    RequestState? hotState,
    String? hotMessage,
    List<GiftsModel>? dataCountry,
    RequestState? countryState,
    String? countryMessage,
  }) {
    return GiftsStates(
        dataHot: dataHot ?? this.dataHot,
        dataNormal: dataNormal ?? this.dataNormal,
        hotMessage: hotMessage ?? this.hotMessage,
        normalMessage: normalMessage ?? this.hotMessage,
        normalState: normalState ?? this.normalState,
        hotState: hotState ?? this.hotState,
        dataCountry: dataCountry ?? this.dataCountry,
        countryMessage: countryMessage ?? this.countryMessage,
        countryState: countryState ?? this.countryState);
  }

  @override
  List<Object?> get props => [
        dataNormal,
        normalState,
        normalMessage,
        dataHot,
        hotState,
        hotMessage,
        countryState,
        countryMessage,
        dataCountry
      ];
}
