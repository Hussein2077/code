
import 'package:equatable/equatable.dart';

abstract class UserReportState extends Equatable {
  const UserReportState();
  
  @override
  List<Object> get props => [];
}

class UserReportInitial extends UserReportState {}
class UserReportLoading extends UserReportState {}

class UserReportSucsses extends UserReportState {
  final String message ; 
  const UserReportSucsses ({required this.message});
}

class UserReportError extends UserReportState {

  final String error ; 
  const UserReportError ({required this.error});
}

