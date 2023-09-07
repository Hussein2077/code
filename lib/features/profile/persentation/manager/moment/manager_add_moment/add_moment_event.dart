
import 'package:equatable/equatable.dart';

abstract class BaseAddMomentEvent extends Equatable {
  const BaseAddMomentEvent();

  @override
  List<Object> get props => [];
}

class AddMomentEvent extends BaseAddMomentEvent {
  final String moment ; 
  final String userId ; 

  const AddMomentEvent({required this.moment , required this.userId});
}