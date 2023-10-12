
import 'package:equatable/equatable.dart';

abstract class BaseDeleteMomentCommentEvent extends Equatable {
  const BaseDeleteMomentCommentEvent();

  @override
  List<Object> get props => [];
}

class DeleteMomentCommentEvent extends BaseDeleteMomentCommentEvent{
  final String momentId ; 
  final String commentId ; 
  const DeleteMomentCommentEvent({required this.commentId , required this.momentId});
}

