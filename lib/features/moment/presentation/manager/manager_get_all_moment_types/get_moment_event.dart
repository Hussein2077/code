
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentEvent extends Equatable {
  const BaseGetMomentEvent();

  @override
  List<Object> get props => [];
}

class GetUserMomentEvent extends BaseGetMomentEvent {
  final String userId ; 
  const GetUserMomentEvent({required this.userId});
}


class LoadMoreUserMomentEvent extends BaseGetMomentEvent{
      final String userId ;
          const LoadMoreUserMomentEvent({ required this.userId});


}

class LocalDeleteMomentEvent extends BaseGetMomentEvent{
  final String momentId ;
  const LocalDeleteMomentEvent({required this.momentId});
}

class LocalLikeMoment extends  BaseGetMomentEvent{
  final String momentId ;
  const LocalLikeMoment({required this.momentId});
}


class LocalCommentMoment extends  BaseGetMomentEvent{
  final String momentId ;
  final String type  ;
  const LocalCommentMoment({required this.type ,  required this.momentId});
}

class LocalGiftMoment extends  BaseGetMomentEvent{
  final String momentId ;
  final int giftsNum ;
  const LocalGiftMoment({  required this.giftsNum, required this.momentId});
}

