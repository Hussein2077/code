import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/data/model/get_room_users_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/number_of_visitor/visitors_room_screen/Widgets/Header_Of_Visitor_Room.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/number_of_visitor/visitors_room_screen/Widgets/Visitors_Screen_room_body.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';
class VisitorsRoomScreen extends StatelessWidget {
  const  VisitorsRoomScreen(
      {required this.roomData,
      required this.myDataModel,
      required this.numberOfVistor,
        required this.layoutMode,
      Key? key})
      : super(key: key);
 final MyDataModel myDataModel;
 final EnterRoomModel roomData;
  final int numberOfVistor;
  final LayoutMode layoutMode ;


  @override
  Widget build(BuildContext context) {

   return BlocBuilder<OnRoomBloc,OnRoomStates>(
    builder: (context, state) {
   if (state is GetAllRoomUsersuccessState){
         return Container(
      height: ConfigSize.screenHeight! / 1.5,
      color: Theme.of(context).colorScheme.background,
      child: Column(children: [
        HeaderofVisitorRoom( numberOfVistor:numberOfVistor),
        Expanded(
            child: SingleChildScrollView(
                child: VisitorsScreenRoomBody(
                  data: state.getRoomUsersEntite,
                  roomData: roomData,
                  myDataModel: myDataModel,
                  layoutMode: layoutMode,
                )))
      ]),
    );
    }else if (state is GetAllRoomUserErrorState){
      return CustomErrorWidget(message: state.errorMassage,);
   }else{
        List<UserDataModel> adminsInRoom = [];
        List<UserDataModel> usersInRoom = [];
        UserDataModel ownerRoom =UserDataModel() ;
        RoomScreen.usersInRoom.forEach((key, value) {
          if(RoomScreen.adminsInRoom.containsKey(key)){
            adminsInRoom.add(value) ;
          }else if(key == roomData.ownerId.toString()){
            ownerRoom = value ;
          }else{
            usersInRoom.add(value);
          }
        });

        GetRoomUsersModel getRoomUsersModel =
        GetRoomUsersModel(owner:ownerRoom ,
            adminData: adminsInRoom, rommId: roomData.id.toString(),
            vistorsData: usersInRoom) ;
        return Container(
          height: ConfigSize.screenHeight! / 1.5,
          color:Theme.of(context).colorScheme.background,
          child: Column(children: [
            HeaderofVisitorRoom( numberOfVistor:numberOfVistor),
           Expanded(child:
                SingleChildScrollView(
                    child: VisitorsScreenRoomBody(
                      data: getRoomUsersModel,
                      roomData: roomData,
                      myDataModel: myDataModel, layoutMode: layoutMode,
                    ))
        ),
          ]),
        );
      }
    });
  }
}
