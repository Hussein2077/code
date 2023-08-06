
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_time_history_model.dart';

abstract class AgencyHistoryTimeState extends Equatable {
  const AgencyHistoryTimeState();
  
  @override
  List<Object> get props => [];
}

class AgencyHistoryTimeInitial extends AgencyHistoryTimeState {}

class AgencyHistoryTimeLoadingState extends AgencyHistoryTimeState {}
class AgencyHistoryTimeSucssesState extends AgencyHistoryTimeState {
  final List<AgencyHistoryTime> data ;
  const AgencyHistoryTimeSucssesState({required this.data});
}
class AgencyHistoryTimeErrorState extends AgencyHistoryTimeState {
  final String error; 

  const AgencyHistoryTimeErrorState({required this.error});

}

