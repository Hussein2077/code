
import 'package:equatable/equatable.dart';

abstract class BaseDeleteMomentEvent extends Equatable {
  const BaseDeleteMomentEvent();

  @override
  List<Object> get props => [];
}

class DeleteMomentEvent extends BaseDeleteMomentEvent {
  final String momentId ; 
  const DeleteMomentEvent({required this.momentId});
}