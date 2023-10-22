import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';

abstract class UsersInRoomState{

  final List<RoomUserMesseagesModel>? data ;
  UsersInRoomState(this.data);
}

class GetUsersInRoomInitialState extends UsersInRoomState {
  GetUsersInRoomInitialState(super.data);
}
class GetUsersInRoomLoadinglState extends UsersInRoomState {
  GetUsersInRoomLoadinglState(super.data);
}
class GetUsersInRoomSucssesState extends UsersInRoomState {
  GetUsersInRoomSucssesState({required data}) : super(data);
}
class GetUsersInRoomErrorState extends UsersInRoomState {
  final String errorMassage ;
  GetUsersInRoomErrorState( super.data, this.errorMassage);
}
