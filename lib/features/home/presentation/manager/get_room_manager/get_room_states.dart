
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';

import 'package:tik_chat_v2/core/model/all_rooms_model.dart';



class GetRoomsStates extends Equatable {
 final List<RoomModelOfAll> rooms  ;
 final String errorMessage  ;
 final RequestState  getRoomsState ;

 const GetRoomsStates({ this.rooms=const [], this.errorMessage ="", this.getRoomsState = RequestState.loading});

  @override
  List<Object?> get props => [rooms,errorMessage,getRoomsState];
}


