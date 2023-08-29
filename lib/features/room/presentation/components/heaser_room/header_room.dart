import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/exit_secreen/exit_widget.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/more_widget/more_dailog.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/number_of_visitor/number_visitor.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/owner_room/owner_room.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/show_ditails_screen/ShowDitailsScreen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/update_room_screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/widgets/custom_contain_room.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';


class HeaderRoom extends StatelessWidget {
  final EnterRoomModel room;
  final MyDataModel myDataModel;
  final String introRoom;
  final String roomName ; 
  final String roomImg;
  final Function() notifyRoom;
  final Function() refreshRoom;
  final int roomMode;
  final String roomType ;
  final  StreamController<List<ZegoUIKitUser>> userInRoomController ;
  final LayoutMode layoutMode ;
   List<AllMainClassesModel>? datatype = [];

   HeaderRoom({
    required this.roomName,
    required this.introRoom,
    required this.notifyRoom,
    required this.roomImg,
    required this.room,
    required this.myDataModel,
    required this.roomMode,
    required this.refreshRoom,
    required this.userInRoomController,
     required this.layoutMode,
    Key? key,
     required this.roomType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<OnRoomBloc, OnRoomStates>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    if (room.ownerId == myDataModel.id) {
                      bottomDailog(
                          context:context,
                          widget:UpdateRoomScreen(
                                          roomDate: room,
                                        )
                          );
                    } else {
                      bottomDailog(
                          context: context,
                          widget: ShowDitailsScreen(roomData: room, roomImg: roomImg,
                            introRoom:introRoom , roomtype: roomType,));
                    }
                  },
                  child: OwnerOfRoom(
                    roomName: roomName,
                    roomData: room,
                    introRoom: introRoom,
                    roomImg: roomImg,

                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      StreamBuilder<List<ZegoUIKitUser>>(
                          stream: ZegoUIKit().getUserListStream(),
                          builder: (context, snapshot) {
                              userInRoomController.add(ZegoUIKit().getAllUsers());
                            return NumberOfVisitor(
                                myDataModel: myDataModel,
                                roomData: room,
                                ownerId: room.ownerId.toString(),
                                numberOfVistor: ZegoUIKit()
                                    .getAllUsers()
                                    .length
                                    .toString(), layoutMode: layoutMode,);
                          }),
                      Visibility(
                          visible: (room.ownerId == myDataModel.id) ||
                              (RoomScreen.adminsInRoom
                                  .containsKey(myDataModel.id.toString())),
                          child: IconButton(
                              onPressed: () {
                                bottomDailog(
                                    context: context,
                                    widget: MoreDailogWidget(
                                      roomId: room.id!,
                                      ownerId: room.ownerId.toString(),
                                      passwordStatus: room.roomPassStatus!,
                                      notifyRoom: notifyRoom,
                                      modeRoom: roomMode,
                                      refreshRoom: refreshRoom,
                                      userId: myDataModel.id.toString(),
                                    ));
                              },
                              icon: Image.asset(AssetsPath.more)
                              )),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          bottomDailog(
                              context: context,
                              widget: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);

},
                                child: ExitWidget(
                                    roomData: room, myDataModel: myDataModel,  ),
                              ));
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal:ConfigSize.defaultSize!-3),
                          child: SizedBox(width: ConfigSize.defaultSize!*3,height: ConfigSize.defaultSize!*3,
                              child: Image.asset(AssetsPath.exitRoom))
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: ConfigSize.defaultSize!-3
          ),
          Row(

  children: [
    ValueListenableBuilder<String>(
        valueListenable: RoomScreen.roomGiftsPrice,
        builder: (context,price,_){
          return CustomContainRoom(
            id: myDataModel.id!,
            icon: Icons.diamond,
            text: price,
            ownerId: room.ownerId.toString(),
            roomData: room,
            myData: myDataModel,
            layoutMode:layoutMode ,
          ) ;
        })
  ],
)
          ,

        ],
      );
    }, listener: (context, state) {
      if (state is ExitRoomSuccesMessageState) {
        Navigator.pop(context);
        errorToast(context: context, title:  state.succesMessage) ;
        BlocProvider.of<OnRoomBloc>(context).add(InitEvent());
      }
      else if (state is ExitRoomErrorMessageState) {
        errorToast(context: context, title:   state.errorMessage) ;
      }
      else if (state is RemovePassRoomSucssesState) {
        sucssesToast(context: context, title:  state.succecMassage) ;
      }
    });

  }
}
