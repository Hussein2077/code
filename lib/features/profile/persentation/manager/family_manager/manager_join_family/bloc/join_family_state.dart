
import 'package:equatable/equatable.dart';

abstract class JoinFamilyState extends Equatable {
  const JoinFamilyState();

  @override
  List<Object> get props => [];
}

class JoinFamilyInitial extends JoinFamilyState {}

class JoinFamilyLoadingState extends JoinFamilyState {}

class JoinFamilySucssesState extends JoinFamilyState {
  final String messeage;
  const JoinFamilySucssesState({required this.messeage});
}

class JoinFamilyErrorState extends JoinFamilyState {
  final String error;
  const JoinFamilyErrorState({required this.error});
}
