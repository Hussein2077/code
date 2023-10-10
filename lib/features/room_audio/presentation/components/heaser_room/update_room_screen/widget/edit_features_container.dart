import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/save_password_room_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/admins_room/admins_room_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/more_widget/back_ground/back_ground_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/more_widget/choose_mode/choose_mode_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';

class EditFeaturesContainer extends StatefulWidget{
  final int roomId;
  final bool passwordStatus;
  final String ownerId;
  final Function() notifyRoom;
  final int modeRoom;
  final String userId;
  final Function() refreshRoom;

  const EditFeaturesContainer(
      {required this.roomId,
        required this.notifyRoom,
        required this.ownerId,
        required this.userId,
        required this.modeRoom,
        required this.passwordStatus,
        required this.refreshRoom,
        Key? key})
      : super(key: key);
  @override
  State<EditFeaturesContainer> createState() => _EditFeaturesContainerState();
}

class _EditFeaturesContainerState extends State<EditFeaturesContainer> {
  List<String> roomFeaturesTitles = [
    StringManager.clearChat.tr(),
    StringManager.lockRoom.tr(),
    StringManager.music2.tr(),
    StringManager.admin.tr(),
    StringManager.theme.tr(),
    StringManager.mode.tr(),
  ];



  @override
  Widget build(BuildContext context) {
    List<Widget> roomFeaturesIcons = [
      Image.asset(
        AssetsPath.chatLock,
        color:
        Theme.of(context).colorScheme.primary
        ,
      ),
      Image.asset(
        AssetsPath.lockRoom,
        color:
        Theme.of(context).colorScheme.primary
        ,
      ),
      Image.asset(
        AssetsPath.music2,
        color:
        Theme.of(context).colorScheme.primary
        ,
      ),Image.asset(
        AssetsPath.addAdmin,

        color:
        Theme.of(context).colorScheme.primary
        ,
      ),Image.asset(
        AssetsPath.paintTheme,
        color:
        Theme.of(context).colorScheme.primary,
        scale: 5
        ,
      ),Image.asset(
        AssetsPath.modeIcon,
        color:
        Theme.of(context).colorScheme.primary,
        scale: 2.5
        ,
      ),





    ];
    List<Function()?> roomFeaturesOnTaps = [
          () {
      clearChatDialog(context);
      },

          () {
            if (RoomScreen.roomIsLoked) {
              BlocProvider.of<OnRoomBloc>(context).add(
                  RemovePassRoomEvent(ownerId: widget.ownerId));

              setState(() {
                RoomScreen.roomIsLoked = false;
              });
            } else {
              Navigator.pop(context);
lockChatDialog();
            }

          },
          () {
            Navigator.pushNamed(context, Routes.music,
                arguments: MusicPramiter(
                    refresh: widget.refreshRoom,
                    ownerId: widget.ownerId));
          },
          () {
            Navigator.pop(context);
            bottomDailog(
                context: context,
                widget: AdminsRoomWidget(
                  userId: widget.userId,
                  ownerId: widget.ownerId,
                ));
          },
          () {
            Navigator.pop(context);
            bottomDailog(
                context: context,
                widget: BackGround(ownerId:widget.ownerId , ));
          },
          () {
            Navigator.pop(context);
            bottomDailog(
                context: context,
                widget:
                ValueListenableBuilder(valueListenable: PkController.isPK,
                    builder:(context,show,_){
                      return  ChooseModeRoom(
                        ownerId: widget.ownerId,
                        modeRoom: widget.modeRoom,
                      ) ;
                    } )
            );
      },
    ];
 return   BlocConsumer<OnRoomBloc, OnRoomStates>(
     listener: (context, state) {
       if (state is UpdateRoomSucsseState) {
         setState(() {
           RoomScreen.roomIsLoked = true;
         });
       }
     },
   builder: (context, state){
     return Padding(
       padding: const EdgeInsets.only(top: 8),
       child: SizedBox(
         height: ConfigSize.defaultSize! * 22,
         width: ConfigSize.defaultSize! * 41,
         child: GridView.builder(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 4, // Number of columns in the grid
             mainAxisSpacing: ConfigSize.defaultSize! * 0.7,
             crossAxisSpacing: ConfigSize.defaultSize! * 0.7,
           ),
           itemCount: roomFeaturesTitles.length,
           padding: EdgeInsets.zero,// Total number of items in the grid
           itemBuilder: (context, index) {
             return Container(
                 width: ConfigSize.defaultSize! * 0.8,
                 height: ConfigSize.defaultSize! * 0.8,
                 padding:
                 EdgeInsets.all(ConfigSize.defaultSize! * 0.5),
                 decoration: BoxDecoration(
                   borderRadius:
                   BorderRadius.circular(ConfigSize.defaultSize!),
                   color: Theme.of(context)
                       .colorScheme
                       .primary
                       .withOpacity(0.1),
                 ),
                 alignment: Alignment.center,
                 child: InkWell(
                   onTap: roomFeaturesOnTaps[index],
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       SizedBox(
                         height: ConfigSize.defaultSize! * 5,
                         width: ConfigSize.defaultSize! * 5,
                         child: roomFeaturesIcons[index],
                       ),
                       SizedBox(
                         height: ConfigSize.defaultSize! * 0.1,
                         width: ConfigSize.defaultSize! * 0.1,
                       ),
                       Text(roomFeaturesTitles[index],
                           style: Theme.of(context)
                               .textTheme
                               .bodyMedium!
                               .copyWith(
                               fontSize:
                               ConfigSize.defaultSize! * 1.5)),
                     ],
                   ),
                 ));
           },
         ),
       ),
     );
   }
 );

  }

  clearChatDialog(BuildContext context){
    return   showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            StringManager.areYouSure.tr(),
            style: TextStyle(
                color: Colors.black,
                fontSize: AppPadding.p18),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: ConfigSize.defaultSize! * 9.2,
                height: AppPadding.p26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.mainColor),
                child: Text(
                  StringManager.no.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppPadding.p16,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              onTap: () {

                Navigator.pop(context);
                clearChat();
              },
              child: Container(
                width: ConfigSize.defaultSize! * 9.2,
                height: AppPadding.p26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.deepPurble),
                child: Text(
                  StringManager.yes.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppPadding.p16,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      },
    );
  }
  lockChatDialog(){
    return
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: ConfigSize.defaultSize!*2.9
            ),

            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(12),
            content: SaveRoomPasswordRoomScreen(
              ownerId: widget.ownerId,
              myData: MyDataModel.getInstance(),
            )),
      );
  }
  Future<void> clearChat()async{
    RoomScreen.clearTimeNotifier.value =
        DateTime.now().millisecondsSinceEpoch;
    var mapInformation = {"messageContent":{
      "message":"removeChat",

    }} ;
    String map = jsonEncode(mapInformation);
    ZegoUIKit().sendInRoomCommand(map ,[]);

  }
}