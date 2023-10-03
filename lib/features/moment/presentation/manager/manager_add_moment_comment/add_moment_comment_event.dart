
import 'package:equatable/equatable.dart';

abstract class BaseAddMomentCommentEvent extends Equatable {
  const BaseAddMomentCommentEvent();

  @override
  List<Object> get props => [];
}

class AddMomentCommentEvent extends BaseAddMomentCommentEvent {
  final String comment ; 
  final String momentId ; 

  const AddMomentCommentEvent ({required this.comment , required this.momentId});
}
