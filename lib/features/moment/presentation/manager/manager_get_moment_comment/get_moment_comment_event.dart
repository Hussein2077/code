

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

class LocalDeleteCommentEvent extends BaseGetMomentCommentEvent{
  final String momentId ;
  final String commentId ;
  const LocalDeleteCommentEvent({required this.momentId,required this.commentId});
}