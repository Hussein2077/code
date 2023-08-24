
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';






class ItemRankInRoom extends StatelessWidget {
  final UserTopModel userTopMode ;


  const ItemRankInRoom({ required this.userTopMode,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
          const  Spacer(
              flex: 2,
            ),
            Stack(
              children: [
            SizedBox(
            width: ConfigSize.defaultSize! * 7,
            height: ConfigSize.defaultSize! * 5,
            ),
                Positioned(
                  //top: 0,
                  left: ConfigSize.defaultSize,
                  bottom: AppPadding.p8,
                  child: UserInfoRow(
                    userData:
                    UserDataModel(frameId:userTopMode.frameId ,
                        frame:userTopMode.frame , profile:ProfileRoomModel(image: userTopMode.avater!) ),),
                ),

              ],
            ),

           const Spacer(
              flex: 2,
            ),
            // const Spacer(flex: AppIntValues.i2),
            SizedBox(
              width: ConfigSize.defaultSize!*17.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userTopMode.name.toString(),
                    style:  TextStyle(
                        fontSize:AppPadding.p14 ,
                        fontWeight: FontWeight.w500,
                        color:Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // name & details
           const Spacer(
              flex: 10,
            ),

            Text(userTopMode.exp.toString(),style:
            TextStyle(color: Colors.blueAccent,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300,fontSize: AppPadding.p12),
            textAlign:TextAlign.center , overflow :TextOverflow.ellipsis),
          const  Spacer(
              flex: 1,
            ),
            Icon(Icons.diamond,size: AppPadding.p20,color: Colors.blue,)

          ],
        ),
        Divider(
    indent: ConfigSize.defaultSize! * 8,
    endIndent: 0,
    thickness: 1,
    height: ConfigSize.defaultSize! * 2,
    color: ColorManager.lightGray.withOpacity(0.2),
    )
      ],
    );
  }
}
