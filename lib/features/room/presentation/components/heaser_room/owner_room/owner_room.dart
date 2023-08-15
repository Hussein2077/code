import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';

class OwnerOfRoom extends StatefulWidget {
  final EnterRoomModel roomData;
  final String introRoom;
  final String roomImg;
    final String roomName;


  const OwnerOfRoom(
      {required this.roomName,
        required this.roomData,
      required this.introRoom,
      required this.roomImg,
      Key? key, })
      : super(key: key);

  @override
  OwnerOfRoomState createState() => OwnerOfRoomState();
}

class OwnerOfRoomState extends State<OwnerOfRoom> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: AppPadding.p16,top: AppPadding.p10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p10),
          color: Colors.white.withOpacity(0.2),
        ),
        padding: EdgeInsets.all(AppPadding.p2),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: ConfigSize.defaultSize! ,
                  top: AppPadding.p4 , bottom: AppPadding.p4),
              width: AppPadding.p36,
              height: AppPadding.p36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppPadding.p16),
                image: widget.roomData.roomCover == null
                    ? const DecorationImage(
                    image: AssetImage(AssetsPath.iconApp))
                    : widget.roomImg == ""
                    ? DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(ConstentApi()
                        .getImage(widget.roomData.roomCover)))
                    : DecorationImage(
                  fit: BoxFit.fill,
                    image: NetworkImage(
                        ConstentApi().getImage(widget.roomImg))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ConfigSize.defaultSize! * 10.5,
                    child: TextScroll(
                      widget.roomName == ""
                          ? widget.roomData.roomName!
                          : widget.roomName,
                      velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                      pauseBetween:const  Duration(milliseconds: 1000),
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: AppPadding.p16,
                      ),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "ID:${widget.roomData.uuidOwnerRoom}",
                        style:  TextStyle(
                          color: ColorManager.lightGray,
                          fontWeight: FontWeight.w300,
                          fontSize: AppPadding.p10,
                        ),
                      ),
                      if( RoomScreen.roomIsLoked)
                        Icon(Icons.lock_outline ,size:AppPadding.p14 ,color: ColorManager.mainColor)
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      )
    ) ;
  }
}
