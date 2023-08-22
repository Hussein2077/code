

import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';

bool checkIsUserOnMic (UserDataModel userData){
 bool isOnMic = false ; 
     RoomScreen.userOnMics.value.forEach((key, value) {
        if(RoomScreen.usersInRoom.containsKey(userData.id.toString())){
      if (userData.id.toString() == value.id) {
        isOnMic = true;
      }
        }

           
        
    });
  return isOnMic;
}



bool cheakisAdminOrHost (UserDataModel userData , MyDataModel myData , EnterRoomModel roomData){
  bool isAdminORHost =
        ((userData.id != myData.id && userData.id != roomData.ownerId) &&
            (RoomScreen.adminsInRoom.containsKey(myData.id) ||
                myData.id == roomData.ownerId));
                return isAdminORHost ;
}


bool myProfileOrNot (UserDataModel userData , MyDataModel myData , ){
  if (userData.id == myData.id){
    return true;
  }else {
    return false;
  }

}


