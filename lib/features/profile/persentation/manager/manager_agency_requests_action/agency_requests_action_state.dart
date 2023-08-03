
import 'package:equatable/equatable.dart';

abstract class AgencyRequestsActionState extends Equatable {
  const AgencyRequestsActionState();
  
  @override
  List<Object> get props => [];
}

class AgencyRequestsActionInitial extends AgencyRequestsActionState {}
class AgencyRequestsActionLoadingState extends AgencyRequestsActionState {}
class AgencyRequestsActionSucssesState extends AgencyRequestsActionState {
  final String message ; 
  const AgencyRequestsActionSucssesState({required this.message});
}
class AgencyRequestsActionErrorState extends AgencyRequestsActionState {
  final String error ; 
  const AgencyRequestsActionErrorState({required this.error});
}
