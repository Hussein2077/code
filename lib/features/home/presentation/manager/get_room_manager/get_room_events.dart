




import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';

abstract class GetRoomEvents extends Equatable {

}


class GetRoomsEvent extends GetRoomEvents {
  final int? countryId ;
  final TypeGetRooms? typeGetRooms ;

  GetRoomsEvent({this.countryId, this.typeGetRooms});

  @override

  List<Object?> get props => [countryId];

}

class LoadMoreRoomsEvent extends GetRoomEvents {
  final int? countryId ;
  final TypeGetRooms? typeGetRooms ;


  LoadMoreRoomsEvent({this.countryId, this.typeGetRooms});

  @override

  List<Object?> get props => [countryId];

}