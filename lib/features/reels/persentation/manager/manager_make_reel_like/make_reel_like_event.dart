import 'package:equatable/equatable.dart';

abstract class BaseMakeReelLikeEvent extends Equatable {
  const BaseMakeReelLikeEvent();

  @override
  List<Object> get props => [];
}

class MakeReelLikeEvent extends BaseMakeReelLikeEvent {
  final String reelId ; 
  const MakeReelLikeEvent({ required this.reelId});
}