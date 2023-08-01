
import 'package:equatable/equatable.dart';

abstract class BaseFollowEvent extends Equatable {
  const BaseFollowEvent();

  @override
  List<Object> get props => [];
}

class FollowEvent extends BaseFollowEvent{
  final String userId ; 
  const FollowEvent({required this.userId});
}

class UnFollowEvent extends BaseFollowEvent{
  final String userId ; 
  const UnFollowEvent({required this.userId});
}
