
import 'package:equatable/equatable.dart';

abstract class BaseMakeMomentLikeEvent extends Equatable {
  const BaseMakeMomentLikeEvent();

  @override
  List<Object> get props => [];
}

class MakeMomentLikeEvent extends BaseMakeMomentLikeEvent {
  final String momentId ;
  const MakeMomentLikeEvent({required this.momentId});
}