
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_history_model.dart';

abstract class AgencyTimeState extends Equatable {
  const AgencyTimeState();
  
  @override
  List<Object> get props => [];
}

class AgencyTimeInitial extends AgencyTimeState {}
class AgencyTimeLoadingState extends AgencyTimeState {}
class AgencyTimeSucssesState extends AgencyTimeState {
  final AgencyHistoryModle data ;
  const AgencyTimeSucssesState({required this.data });
  
}
class AgencyTimeErrorState extends AgencyTimeState {

  final String error ; 
  const AgencyTimeErrorState({required this.error});

}
