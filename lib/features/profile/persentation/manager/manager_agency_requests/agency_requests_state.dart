
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';

abstract class AgencyRequestsState extends Equatable {
  const AgencyRequestsState();
  
  @override
  List<Object> get props => [];
}

class AgencyRequestsInitial extends AgencyRequestsState {}

class AgencyRequestsLoadingState extends AgencyRequestsState {}
class AgencyRequestSucssesState extends AgencyRequestsState {
  final List<OwnerDataModel> data ;
  const AgencyRequestSucssesState ({required this.data});
}
class AgencyRequestsErrorState extends AgencyRequestsState {
  final String error ; 
  const AgencyRequestsErrorState({required this.error});
}
