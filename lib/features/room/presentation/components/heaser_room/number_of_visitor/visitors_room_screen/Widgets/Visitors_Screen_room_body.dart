import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
 
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/data/model/get_room_users_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/number_of_visitor/visitors_room_screen/Widgets/owner_room_row_widget.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/general_room_profile.dart';

class VisitorsScreenRoomBody extends StatelessWidget {
  const VisitorsScreenRoomBody(
      {required this.roomData,
      required this.myDataModel,
        required this.layoutMode ,
      Key? key,
      this.data})
      : super(key: key);
 final EnterRoomModel roomData;
  final GetRoomUsersModel? data;
  final MyDataModel myDataModel;
  final  LayoutMode layoutMode ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          if(data?.owner.profile?.image !=null)
              OwnerRoomRowWidget(
                  isInVisitor: true,
                    userData: data!.owner),

          for (int i = 0; i < data!.adminData.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);

                  bottomDailog(
                      context: context,
                      widget: 
                      GeneralRoomProfile(
                        roomData: roomData,
                        myData: myDataModel,
                        userId: data!.adminData[i].id.toString(),
                          layoutMode:layoutMode
                      )

                  );
                },
                child: UserInfoRow(
                    userData: data!.adminData[i],
                   ),
              ),
            ),

          Divider(
            indent: ConfigSize.defaultSize! *8,
            endIndent: 50,
            thickness: 1,
            height: ConfigSize.defaultSize! * 2,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          for (int i = 0; i < data!.vistorsData.length; i++)
            Padding(
              padding: const  EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  bottomDailog(
                      context: context,
                      widget: const SizedBox()

                      // GenralProfileDialog(
                      //   roomData: roomData,
                      //   myData: myDataModel,
                      //   userId: data!.vistorsData[i].id.toString(),
                      //   layoutMode:layoutMode
                      // )
                  );
                },
                child: UserInfoRow(
                    userData: data!.vistorsData[i],
                ),
              ),
            ),
        ]),

    );
  }
}
