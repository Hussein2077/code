import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';


class FamilyRankingStates extends Equatable {
  final FamilyRankModel? dailyData;
  final RequestState dailyDataRequest;
  final String dailyDatakMassage;
  //
  final FamilyRankModel? weekData;
  final RequestState weekDataRequest;
  final String weekDatakMassage;
  //
  final FamilyRankModel? monthData;
  final RequestState monthDataRequest;
  final String monthDatakMassage;

  const FamilyRankingStates({
    this.dailyData,
    this.dailyDataRequest = RequestState.loading,
    this.dailyDatakMassage = "",
    this.monthData,
    this.monthDataRequest = RequestState.loading,
    this.monthDatakMassage = "",
    this.weekData,
    this.weekDataRequest = RequestState.loading,
    this.weekDatakMassage = "",
  });

  FamilyRankingStates copyWith({
    FamilyRankModel? dailyData,
    RequestState? dailyDataRequest,
    String? dailyDatakMassage,
    FamilyRankModel? weekData,
    RequestState? weekDataRequest,
    String? weekDatakMassage,
    FamilyRankModel? monthData,
    RequestState? monthDataRequest,
    String? monthDatakMassage,
  }) {
    return FamilyRankingStates(
        dailyData: dailyData ?? this.dailyData,
        dailyDataRequest: dailyDataRequest ?? this.dailyDataRequest,
        dailyDatakMassage: dailyDatakMassage ?? this.dailyDatakMassage,
        monthData: monthData ?? this.monthData,
        monthDataRequest: monthDataRequest ?? this.monthDataRequest,
        monthDatakMassage: monthDatakMassage ?? this.monthDatakMassage,
        weekData: weekData ?? this.weekData,
        weekDataRequest: weekDataRequest ?? this.weekDataRequest,
        weekDatakMassage: weekDatakMassage ?? this.weekDatakMassage);
  }

  @override
  List<Object?> get props => [
        dailyData,
        dailyDataRequest,
        dailyDatakMassage,
        monthData,
        monthDataRequest,
        monthDatakMassage,
        weekData,
        weekDataRequest,
        weekDatakMassage
      ];
}

