
import 'package:equatable/equatable.dart';

abstract class BaseJoinToAgencieEvent extends Equatable {
  const BaseJoinToAgencieEvent();

  @override
  List<Object> get props => [];
}

class JoinToAgencieEvent extends BaseJoinToAgencieEvent{
    final String agencieId;
  final String whatsAppNum;
  const JoinToAgencieEvent({required this.agencieId, required this.whatsAppNum});
}