
import 'package:equatable/equatable.dart';

abstract class BaseJoinFamilyEvent extends Equatable {
  const BaseJoinFamilyEvent();

  @override
  List<Object> get props => [];
}

class InitJoinFamilyEvent extends BaseJoinFamilyEvent {}

class JoinFamilyEvent extends BaseJoinFamilyEvent {
  final String id;
  const JoinFamilyEvent({required this.id});
}
