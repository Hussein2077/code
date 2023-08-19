


import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/basic_tool_dialog.dart';



class BasicToolButton extends StatelessWidget {
  final MyDataModel myDataModel ;
  final String roomId ;
  final Function() notifyRoom;
  final LayoutMode layoutMode;
  final String ownerId;
  final bool isOnMic ;
  final EnterRoomModel roomData ;
  const BasicToolButton({required this.roomData, required this.myDataModel ,required this.roomId,
  super.key, required this.notifyRoom, required this.layoutMode, required this.ownerId, required this.isOnMic});

@override
Widget build(BuildContext context) {
  return InkWell(
      onTap: () {



        bottomDailog(context: context,
           widget:  BasicToolDialog(notifyRoom:notifyRoom , layoutMode: layoutMode, ownerId: ownerId, userId:myDataModel.id.toString(), isOnMic: isOnMic, roomData: roomData, ));
      },
      child:   Image.asset(AssetsPath.basicTool,
          width:  ConfigSize.defaultSize!*4,height: ConfigSize.defaultSize!*4)


  );
}
}