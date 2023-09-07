
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/room_handler_manager/room_handler_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/room_handler_manager/room_handler_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/room_handler_manager/room_handler_states.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import '../../../../../core/resource_manger/routs_manger.dart';




class HandlerRoomScreen extends StatefulWidget {
  final RoomHandlerPramiter roomPramiter ;
  const HandlerRoomScreen({required this.roomPramiter, Key? key}) : super(key: key);

  @override
  HandlerRoomScreenState createState() => HandlerRoomScreenState();
}

class HandlerRoomScreenState extends State<HandlerRoomScreen>  with SingleTickerProviderStateMixin{

  @override
  void initState() {


    BlocProvider.of<RoomHandlerBloc>(context)
        .add(EnterRoomEvent(
      isVip:widget.roomPramiter.myDataModel.vip1?.level??0,
      ownerId: widget.roomPramiter.ownerRoomId,
        roomPassword: widget.roomPramiter.passwordRoom));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomHandlerBloc,RoomHandlerStates>(
        builder: (context,state){

          return const  LoadingWidget() ;

        },
        listener: (context,state )async{
          if (state is EnterRoomSuccesMessageState){
          await  Methods().checkIfInRoom(ownerId:state.room.ownerId.toString());
            if(state.room.remainingTime==null){

              if(MyDataModel.getInstance().isAanonymous??false){
                MyDataModel activeMysteriousUser =
                MyDataModel(
                    id: MyDataModel.getInstance().id,
                    uuid: MyDataModel.getInstance().uuid,
                    name: StringManager.mysteriousPerson.tr(),
                    profile:ProfileRoomModel(image:'/hide.jpeg') ,intro: "");
                Navigator.pushReplacementNamed(context,Routes.roomScreen,
                    arguments:RoomPramiter(
                    roomModel: state.room,
                    isHost: false,
                        myDataModel: activeMysteriousUser) ) ;
              }else{

                Navigator.pushReplacementNamed(context,Routes.roomScreen,
                    arguments:RoomPramiter(roomModel: state.room,
                        myDataModel: MyDataModel.getInstance() ,
                    isHost: MyDataModel.getInstance().id.toString() == state.room.ownerId.toString()));
              }
              PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
              await pusher.subscribe(channelName: 'presence-room-${state.room.ownerId}',
                  onEvent: (event){

                  });
              await pusher.connect();
            }
            else{
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (context){
                    return PopUpDialog(headerText:  StringManager().get(reming: state.room.remainingTime!),
                        accpetText: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                        },
                      unShowCancle: true,
                      );

                  }
              );
            }
          }
          else if (state is EnterRoomErrorMessageState ){
            //show dialog here
            showDialog(
                context: context,
                useRootNavigator: false,
                builder: (context){
                  return PopUpDialog(headerText: state.errorMessage,
                    accpetText: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    unShowCancle: true,
                  );
                }
            );

          }

        }
    );
  }
}




