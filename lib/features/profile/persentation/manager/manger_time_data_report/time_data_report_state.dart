


import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_time_entities.dart';

class TimeDataReportState extends Equatable {

 final TimeDataReport? dataToday;
 final RequestState dataTodayReportRequest;
 final String enteringDataTodayMassage;

 final TimeDataReport? dataMonthly;
 final RequestState dataMonthlyReportRequest;
 final String enteringDataMonthlyMassage;

 final TimeDataReport? allInfoData;
 final RequestState allInfoDataRequest;
 final String enteringAllInfoDataMassage;

 const TimeDataReportState ({
   this.dataToday,
   this.dataTodayReportRequest = RequestState.loading,
   this.enteringDataTodayMassage = '',

   this.dataMonthly ,
   this.dataMonthlyReportRequest = RequestState.loading,
   this.enteringDataMonthlyMassage = '',

   this.allInfoData,
   this.allInfoDataRequest = RequestState.loading,
   this.enteringAllInfoDataMassage = '',
});

 TimeDataReportState copyWith({

   TimeDataReport? dataToday,
   RequestState? dataTodayReportRequest,
   String? enteringDataTodayMassage,

   TimeDataReport? dataMonthly,
   RequestState? dataMonthlyReportRequest,
   String? enteringDataMonthlyMassage,

   TimeDataReport? allInfoData,
   RequestState? allInfoDataRequest,
   String? enteringAllInfoDataMassage,

}){
   return TimeDataReportState(
     dataToday: dataToday ?? this.dataToday,
     dataMonthly: dataMonthly ?? this.dataMonthly,
     allInfoData: allInfoData??this.allInfoData,

     dataTodayReportRequest: dataTodayReportRequest ?? this.dataTodayReportRequest,
     dataMonthlyReportRequest: dataMonthlyReportRequest ??this.dataMonthlyReportRequest,
     allInfoDataRequest: allInfoDataRequest ??this.allInfoDataRequest,

     enteringDataTodayMassage: enteringDataTodayMassage ?? this.enteringDataTodayMassage,
     enteringDataMonthlyMassage: enteringDataMonthlyMassage ?? this.enteringDataMonthlyMassage,
     enteringAllInfoDataMassage: enteringAllInfoDataMassage ?? this.enteringAllInfoDataMassage

   );

}



  @override
  List<Object?> get props => [

  dataToday,
  dataTodayReportRequest,
  enteringDataTodayMassage,

  dataMonthly,
  dataMonthlyReportRequest,
  enteringDataMonthlyMassage,

  allInfoData,
  allInfoDataRequest,
  enteringAllInfoDataMassage,

  ];


  }


/*
class TimeDataReportDalySuccess extends TimeDataReportState {
  final TimeDataReport massage;

  TimeDataReportDalySuccess({required this.massage});
}
class TimeDataReportDalyError extends TimeDataReportState {
  final String error;

  TimeDataReportDalyError({required this.error});
}
class TimeDataReportDalyLoading extends TimeDataReportState {}

//mounth
class TimeDataReportMounthSucsses extends TimeDataReportState {
  final TimeDataReport massage;

  TimeDataReportMounthSucsses({required this.massage});
}
class TimeDataReportMounthError extends TimeDataReportState {
  final String error;

  TimeDataReportMounthError({required this.error});
}
class TimeDataReportMounthLoading extends TimeDataReportState {}

//all
class TimeDataReportAllSuccess extends TimeDataReportState {
  final TimeDataReport massage;

  TimeDataReportAllSuccess({required this.massage});
}
class TimeDataReportAllError extends TimeDataReportState {
  final String error;

  TimeDataReportAllError({required this.error});
}
class TimeDataReportAllLoading extends TimeDataReportState {}
*/

