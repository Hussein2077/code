
import 'package:equatable/equatable.dart';

abstract class UsersInRoomEvent extends Equatable {
  const UsersInRoomEvent();

  @override
  List<Object> get props => [];
}


class GetUsersInRoomEvents extends UsersInRoomEvent {
  final String userId;
  const GetUsersInRoomEvents({required this.userId});

}



