
import 'package:equatable/equatable.dart';

abstract class BaseGetFollowingReelsEvent extends Equatable {
  const BaseGetFollowingReelsEvent();

  @override
  List<Object> get props => [];
}

class GetFollowingReelsEvent extends BaseGetFollowingReelsEvent{}