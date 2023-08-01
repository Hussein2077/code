
import 'package:equatable/equatable.dart';

abstract class BaseExitFamilyEvent extends Equatable {
  const BaseExitFamilyEvent();

  @override
  List<Object> get props => [];
}

class ExitFamilyEvent extends BaseExitFamilyEvent {}
