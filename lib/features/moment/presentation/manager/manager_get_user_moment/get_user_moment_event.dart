import 'package:equatable/equatable.dart';

abstract class BaseGetOtherUserMomentEvent extends Equatable {
  const BaseGetOtherUserMomentEvent();

  @override
  List<Object> get props => [];
}

class GetOtherUserMomentEvent extends BaseGetOtherUserMomentEvent {
  final String userId;

  const GetOtherUserMomentEvent({required this.userId});
}

class LoadMoreOtherUserMomentEvent extends BaseGetOtherUserMomentEvent {
  final String userId;

  const LoadMoreOtherUserMomentEvent({required this.userId});
}


class LocalLikeOtherUserMoment extends BaseGetOtherUserMomentEvent {
  final String momentId;

  const LocalLikeOtherUserMoment({required this.momentId});
}

class LocalCommentGetOtherUserMoment extends BaseGetOtherUserMomentEvent {
  final String momentId;

  final String type;

  const LocalCommentGetOtherUserMoment(
      {required this.type, required this.momentId});
}

class LocalGiftOtherUserMoment extends BaseGetOtherUserMomentEvent {
  final String momentId;

  final int giftsNum;

  const LocalGiftOtherUserMoment(
      {required this.giftsNum, required this.momentId});
}
