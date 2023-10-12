
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentILikeItEvent extends Equatable {
  const BaseGetMomentILikeItEvent();

  @override
  List<Object> get props => [];
}

class GetMomentIliKEitEvent extends BaseGetMomentILikeItEvent {
   
  const GetMomentIliKEitEvent();
}


class LoadMoreMomentIlikeItEvent extends BaseGetMomentILikeItEvent{
          const LoadMoreMomentIlikeItEvent();


}


class LocalDeleteMomentILikedEvent extends BaseGetMomentILikeItEvent{
  final String momentId ;
  const LocalDeleteMomentILikedEvent({required this.momentId});
}


class LocalLikeMomentIliked extends  BaseGetMomentILikeItEvent{
  final String momentId ;
  const LocalLikeMomentIliked({required this.momentId});
}


class LocalCommentIlikedMomentEvent extends  BaseGetMomentILikeItEvent{
  final String momentId ;
  final String type  ;
  const LocalCommentIlikedMomentEvent({required this.type ,  required this.momentId});
}

class LocalGiftILikedMoment extends  BaseGetMomentILikeItEvent{
  final String momentId ;
  final int giftsNum ;
  const LocalGiftILikedMoment({   required this.momentId,required this.giftsNum});
}

