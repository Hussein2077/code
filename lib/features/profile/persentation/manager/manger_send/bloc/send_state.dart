
import 'package:equatable/equatable.dart';

abstract class SendState extends Equatable {
  const SendState();

  @override
  List<Object> get props => [];
}

class SendInitial extends SendState {}

class SendLoadingState extends SendState {}

class SendSucssesState extends SendState {
  final String massage;
  const SendSucssesState({required this.massage});
}

class SendErrorState extends SendState {
  final String massage;
  const SendErrorState({required this.massage});
}
