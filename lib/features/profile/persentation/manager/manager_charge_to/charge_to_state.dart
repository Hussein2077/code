

import 'package:equatable/equatable.dart';

import '../../../data/model/charge_to_model.dart';

abstract class ChargeToState extends Equatable {
  const ChargeToState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChargeToInitial extends ChargeToState {}

class ChargeToLoadingState extends ChargeToState {}

class ChargeToErrorState extends ChargeToState {
  final String error;
  const ChargeToErrorState({required this.error});
}

class ChargeToSuccessState extends ChargeToState {
 final ChargeToModel chargeToModel;
 const ChargeToSuccessState({required this.chargeToModel});
}
