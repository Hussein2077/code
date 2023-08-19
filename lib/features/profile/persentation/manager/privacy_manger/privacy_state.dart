import 'package:equatable/equatable.dart';

abstract class PrivacyState extends Equatable {
  @override
  List<Object> get props => [];
}

class PrivacyInitial extends PrivacyState {}

class LoadingState extends PrivacyState {}

class SucssesState extends PrivacyState {
  final String massege;

  SucssesState({required this.massege});
}

class ErrorState extends PrivacyState {
  final String massege ; 
  ErrorState({required this.massege});

}
