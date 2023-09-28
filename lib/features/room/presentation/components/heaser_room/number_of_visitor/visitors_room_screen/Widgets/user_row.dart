import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/general_room_profile.dart';

class UserRow extends StatelessWidget {
  final RoomVistorModel roomVistorModel;
  final LayoutMode layoutMode ;
  final EnterRoomModel roomData ;

  const UserRow({super.key, required this.roomVistorModel, required this.layoutMode, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          bottomDailog(
              context: context,
              widget: GeneralRoomProfile(

                  userId:roomVistorModel.id.toString() ,
                  myData:MyDataModel.getInstance(),
                  roomData:roomData,
                  layoutMode:layoutMode,
              )
          );
        },
        child: Row(
          children: [
            SizedBox(width:ConfigSize.defaultSize! ,),
            UserImage(image: roomVistorModel.image,boxFit: BoxFit.cover,frame: roomVistorModel.frame,
              frameId: roomVistorModel.frameId,
              imageSize: ConfigSize.defaultSize! * 5,
            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientTextVip(
                  text: "${roomVistorModel.name}   (${chckType(roomVistorModel.type)})" ?? "",
                  textStyle: Theme.of(context).textTheme.bodyLarge!,
                  isVip: roomVistorModel.hasColorName,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!*3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LevelContainer(
                        image: roomVistorModel.revicerLevelImg,
                        width: ConfigSize.defaultSize!*5,
                        height: ConfigSize.defaultSize!*2,
                      ),
                      SizedBox(width:ConfigSize.defaultSize! ,),
                      LevelContainer(
                        width: ConfigSize.defaultSize!*5,
                        height: ConfigSize.defaultSize!*2,
                         image: roomVistorModel.senderLevelImg,
                      ),             SizedBox(width:ConfigSize.defaultSize! ,),
                      AristocracyLevel(
                        level: roomVistorModel.vipLevel,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
      default:
        return '';
    }
  }
}
