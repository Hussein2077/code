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

class LocalLikeFollowingMoment extends  BaseGetFollowingMomentEvent{
  final String momentId ;
  const LocalLikeFollowingMoment({required this.momentId});
}


class LocalCommentFollowingMomentEvent extends  BaseGetFollowingMomentEvent{
  final String momentId ;
  final String type  ;
  const LocalCommentFollowingMomentEvent({required this.type ,  required this.momentId});
}

class LocalFollowingGiftMoment extends  BaseGetFollowingMomentEvent{
  final String momentId ;
  final int giftsNum;
  const LocalFollowingGiftMoment({   required this.momentId,required this.giftsNum});
}