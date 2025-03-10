import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/all_main_classes_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/admin_more_dailog/admin_more_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/exit_secreen/exit_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/number_of_visitor/number_visitor.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/owner_room/owner_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/show_ditails_screen/ShowDitailsScreen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/update_room_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/achievmenet_image.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/custom_contain_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/extra_room_data_manager/extra_room_data_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/extra_room_data_manager/extra_room_data_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class HeaderRoom extends StatelessWidget {
  final EnterRoomModel room;
  final MyDataModel myDataModel;
  final String introRoom;
  final String roomName;

  final String roomImg;
  final int roomMode;
  final String roomType;

  final LayoutMode layoutMode;

  List<AllMainClassesModel>? datatype = [];

  HeaderRoom({
    required this.roomName,
    required this.introRoom,
    required this.roomImg,
    required this.room,
    required this.myDataModel,
    required this.roomMode,
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
              OwnerOfRoom(
                roomName: roomName,
                roomData: room,
                introRoom: introRoom,
                roomImg: roomImg,
              ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       SizedBox(
                        width: ConfigSize.defaultSize!,
                      ),
                      StreamBuilder<List<ZegoUIKitUser>>(
                          stream: ZegoUIKit.instance.getUserListStream(),
                          builder: (context, snapshot) {
                            int numberOfUsers = ZegoUIKit.instance.getAllUsers().length;
                            for(int i = 0; i < ZegoUIKit.instance.getAllUsers().length; i++){
                              if(ZegoUIKit.instance.getAllUsers()[i].id.startsWith('-1')){
                                numberOfUsers --;
                              }
                            }
                            return NumberOfVisitor(
                              myDataModel: myDataModel,
                              roomData: room,
                              ownerId: room.ownerId.toString(),
                              numberOfVistor: numberOfUsers.toString(),
                              layoutMode: layoutMode,
                            );
                          }),
                      Visibility(
                          visible: (room.ownerId == myDataModel.id) || (RoomScreen.adminsInRoom.containsKey(myDataModel.id.toString())),
                          child: IconButton(
                              onPressed: () {
                                if (room.ownerId == myDataModel.id) {
                                  bottomDailog(
                                      context: context,
                                      widget: UpdateRoomScreen(
                                        roomDate: room,
                                        room: room,
                                        myDataModel: myDataModel,
                                      ));
                                } else if(RoomScreen.adminsInRoom.containsKey(myDataModel.id.toString()) ){
                                  bottomDailog(
                                      context: context,
                                      widget: AdminMoreDailog(
                                        ownerId:room.ownerId.toString() ,
                                    
                                      ));
                                } else {
                                  bottomDailog(
                                      context: context,
                                      widget: ShowDitailsScreen(
                                        roomData: room,
                                        roomImg: roomImg,
                                        introRoom: introRoom,
                                        roomtype: roomType,
                                      ));
                                }
                              },
                              icon: Image.asset(AssetsPath.settingRoom,scale: 2,))),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          bottomDailog(
                              context: context,
                              widget: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ExitWidget(
                                  roomData: room,
                                  myDataModel: myDataModel,
                                ),
                              ));


                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ConfigSize.defaultSize! - 3),
                            child: SizedBox(
                                width: ConfigSize.defaultSize! * 3,
                                height: ConfigSize.defaultSize! * 3,
                                child: Image.asset(AssetsPath.exitRoom))),
                      )
                    ],
                  ),

            ],
          ),
          Row(
            children: [
              ValueListenableBuilder<String>(
                  valueListenable: RoomScreen.roomGiftsPrice,
                  builder: (context, price, _) {
                    return CustomContainRoom(
                      id: myDataModel.id!,
                      text: price,
                      ownerId: room.ownerId.toString(),
                      roomData: room,
                      myData: myDataModel,
                      layoutMode: layoutMode,
                    );
                  }),
              SizedBox(
                  width: ConfigSize.defaultSize!
              ),
              BlocBuilder<ExtraRoomDataBloc, ExtraRoomDataState>(
                builder: (context, state) {
                  if(state is ExtraRoomDataSuccessState) {
                    return SizedBox(
                      width: ConfigSize.defaultSize! * 8,
                      height: ConfigSize.defaultSize! * 2.5,
                      child: ListView.builder(
                          itemCount: state.data.data!.achievements!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return AchievementCachImageWidget(
                              width: ConfigSize.screenWidth! * .08,
                              url:ConstentApi().getImage(state.data.data!.achievements![index].image),
                            );
                          }
                      ),
                    );
                  }else if(state is ExtraRoomDataFilureState){
                    return Container();
                  }else{
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      );
    }, listener: (context, state) {
      if (state is ExitRoomSuccesMessageState) {
        Navigator.pop(context);
        errorToast(context: context, title: state.succesMessage);
        BlocProvider.of<OnRoomBloc>(context).add(InitRoomEvent());
      } else if (state is ExitRoomErrorMessageState) {
        errorToast(context: context, title: state.errorMessage);
      } else if (state is RemovePassRoomSucssesState) {
        sucssesToast(context: context, title: state.succecMassage);
      }
    });
  }
}