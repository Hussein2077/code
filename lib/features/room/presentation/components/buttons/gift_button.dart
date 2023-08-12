;
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/Dailog_Method.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';



class GiftButton extends StatelessWidget {
  const GiftButton({required this.myDataModel,required this.listAllUsers , required this.listUsers, required this.roomData, super.key});
  final MyDataModel myDataModel;
  final List<ZegoUIKitUser>  listUsers ;
  final List<ZegoUIKitUser>  listAllUsers ;
  final EnterRoomModel? roomData ;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()  {


        dialogRoom(
            context: context,
            widget: GiftScreen(
              listAllUsers:listAllUsers,
              listUsers:listUsers,
              roomData:roomData!,
              myDataModel: myDataModel,
            ));
      },
      child:  Image(
          width:  ConfigSize.defaultSize!*5.7,
            height: ConfigSize.defaultSize!*6.9,
            image: const  AssetImage(AssetsPath.giftbox),
          ),
    );
  }
}
