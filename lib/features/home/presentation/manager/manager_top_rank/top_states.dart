import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';




class TopStates extends Equatable {
  final RankingModel? usersRankDD;
  final RequestState dDState;
  final String dDError;
  final RankingModel? usersRankDW;
  final RequestState dWState;
  final String dWError;
  final RankingModel? usersRankDM;
  final RequestState dMState;
  final String dMError;
  final RankingModel? usersRankCD;
  final RequestState cDState;
  final String cDError;
  final RankingModel? usersRankCW;
  final RequestState cWState;
  final String cWError;
  final RankingModel? usersRankCM;
  final RequestState cMState;
  final String cMError;

  const TopStates(
      {this.usersRankCD,
      this.usersRankCM,
      this.usersRankCW,
      this.usersRankDD,
      this.usersRankDM,
      this.usersRankDW,
      this.cMState = RequestState.loading,
      this.cDState = RequestState.loading,
      this.cWState = RequestState.loading,
      this.dDState = RequestState.loading,
      this.dMState = RequestState.loading,
      this.dWState = RequestState.loading,
      this.cDError = "",
      this.cMError = "",
      this.cWError = "",
      this.dDError = "",
      this.dMError = "",
      this.dWError = ""});

  TopStates copyWith({
    RankingModel? usersRankDD,
    RequestState? dDState,
    String? dDError,
    RankingModel? usersRankDW,
    RequestState? dWState,
    String? dWError,
    RankingModel? usersRankDM,
    RequestState? dMState,
    String? dMError,
    RankingModel? usersRankCD,
    RequestState? cDState,
    String? cDError,
    RankingModel? usersRankCW,
    RequestState? cWState,
    String? cWError,
    RankingModel? usersRankCM,
    RequestState? cMState,
    String? cMError,
  }) {
    return TopStates(
        usersRankDD: usersRankDD?? this.usersRankDD,
        usersRankDM: usersRankDM ?? this.usersRankDM,
        usersRankDW: usersRankDW ?? this.usersRankDW,
        usersRankCD: usersRankCD ?? this.usersRankCD,
        usersRankCM: usersRankCM ?? this.usersRankCM,
        usersRankCW: usersRankCW ?? this.usersRankCW,
        dDState: dDState ?? this.dDState,
        dMState: dMState ?? this.dMState,
        dWState: dWState ?? this.dWState,
        cDState: cDState ?? this.cDState,
        cMState: cMState ?? this.cMState,
        cWState: cWState ?? this.cWState,
        dDError: dDError ?? this.dDError,
        dMError: dMError ?? this.dMError,
        dWError: dWError ?? this.dWError,
        cDError: cDError ?? this.cDError,
        cMError: cMError ?? this.cMError,
        cWError: cWError ?? this.cWError);
  }

  @override
  List<Object?> get props => [
        usersRankDD,
        dDState,
        dDError,
        usersRankDW,
        dWState,
        dWError,
        usersRankDM,
        dMState,
        dMError,
        usersRankCD,
        cDState,
        cDError,
        usersRankCW,
        cWState,
        cWError,
        usersRankCM,
        cMState,
        cMError,
      ];
}
