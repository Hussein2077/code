
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_agency_model.dart';

abstract class ShowAgencyState extends Equatable {
  const ShowAgencyState();
  
  @override
  List<Object> get props => [];
}

class ShowAgencyInitial extends ShowAgencyState {}

class ShowAgencyLoadingState extends ShowAgencyState {}
class ShowAgencySucssesState extends ShowAgencyState {
  final ShowAgencyModel data ;
  const ShowAgencySucssesState({required this.data});
}
class ShowAgencyErrorState extends ShowAgencyState {
  final String error ; 
  const ShowAgencyErrorState({required this.error ,});
}
