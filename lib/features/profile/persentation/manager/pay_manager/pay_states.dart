import 'package:equatable/equatable.dart';

abstract class payState extends Equatable {
  @override
  List<Object> get props => [];
}

class payInitial extends payState {}

class payLoadingState extends payState {}

class paySucssesState extends payState {
  final String massege;
  paySucssesState({required this.massege});
}

class payErrorState extends payState {
  final String massege ;
  payErrorState({required this.massege});

}
