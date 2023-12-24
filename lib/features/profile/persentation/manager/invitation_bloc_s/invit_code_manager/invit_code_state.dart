
import 'package:equatable/equatable.dart';

abstract class InvitCodeState extends Equatable {
  const InvitCodeState();

  @override
  List<Object> get props => [];
}

class InvitCodeInitial extends InvitCodeState {}

class InvitCodeLoadingState extends InvitCodeState {}

class InvitCodeScussesState extends InvitCodeState {
  final String massage;
  const InvitCodeScussesState({required this.massage});
}

class InvitCodeErorrState extends InvitCodeState {
  final String massage;
  const InvitCodeErorrState({required this.massage});
}


