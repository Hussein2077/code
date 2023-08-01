
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';

abstract class GetFollwersRoomState extends Equatable {
  const GetFollwersRoomState();
  
  @override
  List<Object> get props => [];
}

class GetFollwersRoomInitial extends GetFollwersRoomState {}


class GetFollwersRoomSucssesState extends GetFollwersRoomState {

  final AllRoomsDataModel rooms ;
  const GetFollwersRoomSucssesState({required this.rooms}) ; 
  
}
class GetFollwersRoomErrorState extends GetFollwersRoomState {
  final String error ;
  const GetFollwersRoomErrorState ({required this.error});
}
class GetFollwersRoomLoadingState extends GetFollwersRoomState {}
