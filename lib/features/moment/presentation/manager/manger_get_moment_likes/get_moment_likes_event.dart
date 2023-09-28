
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentLikesEvent extends Equatable {
  const BaseGetMomentLikesEvent();

  @override
  List<Object> get props => [];
}

class GetMomentLikesEvent extends BaseGetMomentLikesEvent {
  final String momentId ; 
  const GetMomentLikesEvent({required this.momentId});
}


class GetMoreMomentLikesEvent extends BaseGetMomentLikesEvent{
      final String momentId ;
          const GetMoreMomentLikesEvent({ required this.momentId});


}