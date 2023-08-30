
import 'package:equatable/equatable.dart';

abstract class BaseGetReelsCommentsEvent extends Equatable {
  const BaseGetReelsCommentsEvent();

  @override
  List<Object> get props => [];
}

class GetReelsCommentsEvent extends BaseGetReelsCommentsEvent{
  final String reelId ;
const GetReelsCommentsEvent({required this.reelId});

}
class LoadMoreReelsCommentsEvent extends BaseGetReelsCommentsEvent{
  final String reelId;
  const LoadMoreReelsCommentsEvent({required this.reelId });

}
