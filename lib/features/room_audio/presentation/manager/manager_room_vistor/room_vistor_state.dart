





import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';

abstract class RoomVistorState{
   final List<RoomVistorModel>? data ;
   RoomVistorState(this.data);
  

}

class GetRoomVistorInitialState extends RoomVistorState {
   GetRoomVistorInitialState(super.data);
}
class GetRoomVistorLoadinglState extends RoomVistorState {
    GetRoomVistorLoadinglState(super.data);
}
class GetRoomVistorSucssesState extends RoomVistorState {
    GetRoomVistorSucssesState({required data}) : super(data);
}
class GetRoomVistorErrorState extends RoomVistorState {
  final String errorMassage ; 
   GetRoomVistorErrorState( super.data, this.errorMassage);
}
