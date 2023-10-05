import 'package:equatable/equatable.dart';

abstract class BaseGetFollowingMomentEvent extends Equatable {
  const BaseGetFollowingMomentEvent();

  @override
  List<Object> get props => [];
}

class GetFollowingMomentEvent extends BaseGetFollowingMomentEvent {
   
  const GetFollowingMomentEvent();
}


class LoadMoreFollowingMomentEvent extends BaseGetFollowingMomentEvent{
          const LoadMoreFollowingMomentEvent();


}