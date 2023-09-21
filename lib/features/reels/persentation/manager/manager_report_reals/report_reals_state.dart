import 'package:equatable/equatable.dart';

abstract class ReportRealsState extends Equatable {

  @override
  List<Object> get props => [];

  const ReportRealsState();
}

class ReportRealsInitial extends ReportRealsState {}

class ReportReelsLoadingState extends ReportRealsState {}
class ReportReelsSucssesState extends ReportRealsState {
  final String message ;
  const ReportReelsSucssesState ({required this.message});
}
class ReportReelsErrorState extends ReportRealsState {
  final String error;

  const ReportReelsErrorState({required this.error });
}