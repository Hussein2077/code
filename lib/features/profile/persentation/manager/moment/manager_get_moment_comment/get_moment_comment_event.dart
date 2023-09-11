

abstract class BaseGetMomentCommentEvent  {
  const BaseGetMomentCommentEvent();


}

class GetMomentCommentEvent extends BaseGetMomentCommentEvent {
    final String momentId ;
    const GetMomentCommentEvent({ required this.momentId});


}

class LoadMoreMomentCommentEvent extends BaseGetMomentCommentEvent{
      final String momentId ;
          const LoadMoreMomentCommentEvent({ required this.momentId});


}