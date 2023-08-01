
import 'package:equatable/equatable.dart';

abstract class BaseFamilyRequestEvent extends Equatable {
  const BaseFamilyRequestEvent();

  @override
  List<Object> get props => [];
}

class GetFamilyRequestEvent extends BaseFamilyRequestEvent {}
