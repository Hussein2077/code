import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/general_room_profile.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
                  children: [
                    GradientTextVip(
                      text: roomVistorModel.name,
                      textStyle: Theme.of(context).textTheme.bodyLarge!,
                      isVip: roomVistorModel.hasColorName,
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize! * 2,
                    ),
                    if(roomVistorModel.type == 0) Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorManager.orang),child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Icon(Icons.home, color: Colors.white, size: ConfigSize.defaultSize!*2,),
                    ),),
                    if(roomVistorModel.type == 1) Image.asset(AssetsPath.adminMark, scale: 2,),
                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
