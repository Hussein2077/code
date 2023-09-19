import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room/data/model/room_vistor_model.dart';

class UserRow extends StatelessWidget {
  final RoomVistorModel roomVistorModel;
  const UserRow({super.key,required this.roomVistorModel});




  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        UserImage(image: roomVistorModel.image),
        Column(
          children: [
            GradientTextVip(
              text: roomVistorModel.name+chckType(roomVistorModel.type)?? "",
              textStyle: Theme.of(context).textTheme.bodyLarge!,

              isVip:  roomVistorModel.hasColorName ,
            ),
            Row(

              children: [
                if(roomVistorModel.revicerLevelImg!=null)
                LevelContainer(
                  image: roomVistorModel.revicerLevelImg,

                ),
                if(roomVistorModel.senderLevelImg!=null)
                  LevelContainer(
                  image: roomVistorModel.senderLevelImg,

                ),
                if(roomVistorModel.vipLevel!=null)

                  AristocracyLevel(

                  level: roomVistorModel.vipLevel,
                ),
              ],
            ),
          ],
        )
      ],
    );

  }
  String chckType(int type) {
    switch (type) {
      case 0:
        return 'Owner';
      case 1:
        return 'Admin';
      case 2:
        return '';
      default :
        return '';
    }
  }
}