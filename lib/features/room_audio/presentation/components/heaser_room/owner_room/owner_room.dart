import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/widget/edit_features_container.dart';

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
  static ValueNotifier<int> editRoom = ValueNotifier<int>(0);

  @override
  OwnerOfRoomState createState() => OwnerOfRoomState();
}

class OwnerOfRoomState extends State<OwnerOfRoom> {
  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: EdgeInsets.only(top: AppPadding.p20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors:
              ColorManager.mainColorList
          ),
          borderRadius: BorderRadius.only(
            topRight:Radius.circular(ConfigSize.defaultSize!*10),
            bottomRight:Radius.circular(ConfigSize.defaultSize!*10),
          ),

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

                        ValueListenableBuilder(
                            valueListenable: OwnerOfRoom.editRoom,
                            builder: (context,_, Widget? widget){
                              if( EditFeaturesContainer.roomIsLoked){
                                return  Icon(Icons.lock_outline ,size:AppPadding.p14 ,color: ColorManager.mainColor) ;
                              }else{
                                return const SizedBox();
                              }

                            })

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
