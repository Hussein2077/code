
import 'package:equatable/equatable.dart';

abstract class BaseMakeReelCommentEvent extends Equatable {
  const BaseMakeReelCommentEvent();

  @override
  List<Object> get props => [];
}

class MakeReelCommentEvent extends BaseMakeReelCommentEvent {
  final String reelId ; 
  final String comment ; 
  const MakeReelCommentEvent({required this.comment , required this.reelId});
}