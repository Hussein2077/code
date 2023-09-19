import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/widgets/top_in_room_screen/top_in_room_screen.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_top_inroom/topin_room_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_top_inroom/topin_room_events.dart';

class CustomContainRoom extends StatelessWidget {
  final IconData icon;
  final String text;
  final String ownerId ;
  final int id;
  final EnterRoomModel roomData ;
  final MyDataModel myData ;
  final LayoutMode layoutMode ;

  const CustomContainRoom({required this.id,required this.layoutMode ,
    Key? key, required this.myData, required this.roomData,
    required this.icon,required this.ownerId, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        BlocProvider.of<TobinRoomBloc>(context)..add(getTopIn24HoursRoomEvent(classId: '3',typeDate: '1',ownerId:ownerId ))
          ..add(getTopInTotalRoomEvent(classId: '3' ,typeDate: '4',ownerId: ownerId)) ;
        bottomDailog(
            context: context,
            widget:  TopInRoomScreen(id: id, roomData: roomData, myData: myData, layoutMode:layoutMode ,) );
      },
      child: Container(

        decoration: const BoxDecoration(
          image: DecorationImage(

            image: AssetImage(AssetsPath.contanerDiamodn)
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ConfigSize.defaultSize!,

        ),
        child: Padding(
          padding:  EdgeInsets.only(
            right: ConfigSize.defaultSize!,
            top: ConfigSize.defaultSize!,
            bottom: ConfigSize.defaultSize!,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:ConfigSize.defaultSize!*2,
                height:ConfigSize.defaultSize!*2 ,
                decoration: const BoxDecoration(

                    image: DecorationImage(
                      image: AssetImage(AssetsPath.cup),

                    )
                ),
              ),
              Text(
                text,
                style:  TextStyle(color: Colors.white, fontSize:ConfigSize.defaultSize!+2),
              ),
              SizedBox(
                width: ConfigSize.defaultSize!-5,
              ),
              Icon(Icons.arrow_forward_ios_outlined,color: Color(0xffFFDC84),size: ConfigSize.defaultSize!),
            ],
          ),
        ),
      )
       ,
    );
  }
}
