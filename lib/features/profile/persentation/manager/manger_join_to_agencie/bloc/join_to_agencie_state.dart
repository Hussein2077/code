
import 'package:equatable/equatable.dart';

abstract class JoinToAgencieState extends Equatable {
  const JoinToAgencieState();
  
  @override
  List<Object> get props => [];
}

class JoinToAgencieInitial extends JoinToAgencieState {}

class JoinToAgencieLoadingState extends JoinToAgencieState {}

class JoinToAgencieSucssesState extends JoinToAgencieState {
  final bool success;
  const JoinToAgencieSucssesState({required this.success});
}

class JoinToAgencieErrorState extends JoinToAgencieState {
  final String error;
  const JoinToAgencieErrorState({required this.error});
}

