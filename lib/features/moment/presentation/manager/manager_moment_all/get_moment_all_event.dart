
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentAllEvent extends Equatable {
  const BaseGetMomentAllEvent();

  @override
  List<Object> get props => [];
}

class GetMomentAllEvent extends BaseGetMomentAllEvent {
   
  const GetMomentAllEvent();
}


class LoadMoreMomentAllEvent extends BaseGetMomentAllEvent{
          const LoadMoreMomentAllEvent();


}

class LocalDeleteMomentAllEvent extends BaseGetMomentAllEvent{
  final String momentId ; 
  const LocalDeleteMomentAllEvent({required this.momentId});
}


class LocalLikeMomentAll extends  BaseGetMomentAllEvent{
  final String momentId ; 
  const LocalLikeMomentAll({required this.momentId});
}


class LocalCommentMomentAllEvent extends  BaseGetMomentAllEvent{
  final String momentId ; 
  final String type  ; 
  const LocalCommentMomentAllEvent({required this.type ,  required this.momentId});
}

class LocalGiftMomentAllEvent extends  BaseGetMomentAllEvent{
  final String momentId ;
  final int giftsNum ;
  const LocalGiftMomentAllEvent({   required this.momentId,required this.giftsNum});
}