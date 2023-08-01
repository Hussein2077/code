
import 'package:equatable/equatable.dart';

abstract class BaseGetFollwersRoomEvent extends Equatable {
  const BaseGetFollwersRoomEvent();

  @override
  List<Object> get props => [];
}

class GetFollwersRoomEvent extends BaseGetFollwersRoomEvent{
  final String type ;
  const  GetFollwersRoomEvent({required this.type ,});
}