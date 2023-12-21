

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';

class AdminOrOwnerContainer extends StatelessWidget {
  final int? userId;
  final int? roomOwnerId ;
  const AdminOrOwnerContainer({ this.userId ,this.roomOwnerId,super.key});

  @override
  Widget build(BuildContext context) {
    if(userId == roomOwnerId){
      return Container(

        padding: EdgeInsets.symmetric(
            horizontal: ConfigSize.defaultSize!*0.6,

        ),
        decoration: BoxDecoration(color: ColorManager.orange2,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(StringManager.owner, style: TextStyle(color: Colors.white , fontSize: ConfigSize.defaultSize!*1),),
            Image.asset(AssetsPath.admin , scale: 3,),
          ],),
      );
    }else if(RoomScreen.adminsInRoom.containsKey(userId)){
      return Container(

        padding: EdgeInsets.symmetric(
            horizontal: ConfigSize.defaultSize!*0.6,
            vertical: ConfigSize.defaultSize!*0.1
        ),
        decoration: BoxDecoration(color: ColorManager.blue,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(StringManager.owner, style: TextStyle(color: Colors.white , fontSize: ConfigSize.defaultSize!),),
            Image.asset(AssetsPath.ownerIcon , scale: 1.5,),
          ],),
      );
    }else{
      return const SizedBox();
    }
  }
}