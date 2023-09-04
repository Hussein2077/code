
import 'package:equatable/equatable.dart';

abstract class BaseGetUserReelsEvent extends Equatable {
  const BaseGetUserReelsEvent();

  @override
  List<Object> get props => [];
}

class GetUserReelEvent extends BaseGetUserReelsEvent {
 final String? id ; 
 const  GetUserReelEvent ({this.id});
  
}

class LoadMoreUserReelsEvent extends BaseGetUserReelsEvent{
   final String? id ; 
   const LoadMoreUserReelsEvent ({this.id});

}