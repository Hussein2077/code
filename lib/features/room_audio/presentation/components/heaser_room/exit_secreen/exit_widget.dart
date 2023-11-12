
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'dart:ui' as ui ;
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';


class ExitWidget extends StatefulWidget {
  final EnterRoomModel roomData ;
  final MyDataModel myDataModel ;



  const  ExitWidget({  required this.roomData,required this.myDataModel, Key? key}) : super(key: key);

  @override
  ExitWidgetState createState() => ExitWidgetState();
}

class ExitWidgetState extends State<ExitWidget> {
  bool animation = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const  Duration(milliseconds: 200),(){
      setState(() {
        animation = true ;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
        width: ConfigSize.screenWidth,
        height: ConfigSize.screenHeight,
        color: Colors.black.withOpacity(0.4),
        child: Directionality(
          textDirection:ui.TextDirection.ltr,
          child:Stack(
            children: [
              AnimatedPositioned(
                duration: const  Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                top:animation?  ConfigSize.defaultSize!*26:-200 ,
                left: (ConfigSize.screenWidth! /2)-ConfigSize.defaultSize!*5 ,
                child:
                InkWell(
                  onTap: (){
                    MainScreen.iskeepInRoom.value=true;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    MainScreen.roomData = widget.roomData;
                    RoomScreen.outRoom = true ;
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AssetsPath.saveRoom, width:  ConfigSize.defaultSize!*10, height: ConfigSize.defaultSize!*10,),
                      Padding(padding:const EdgeInsets.all(8),
                        child: Text(StringManager.save.tr(),style:const TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 16),),
                      )
                    ],
                  ),
                ) ,
              ) ,
              AnimatedPositioned(
                  bottom:  animation?  ConfigSize.defaultSize!*26:-200,
                  left: (ConfigSize.screenWidth! /2)-ConfigSize.defaultSize!*5 ,
                  duration:const  Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: InkWell(
                    onTap: ()async{
                      MainScreen.iskeepInRoom.value=false;
                      Navigator.pop(context);
                      Navigator.pop(context);
                      await   Methods.instance.exitFromRoom(widget.roomData.ownerId.toString(), context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(AssetsPath.exitRoom, width:  ConfigSize.defaultSize!*10, height: ConfigSize.defaultSize!*10,),
                        Padding(padding: const EdgeInsets.all(8),
                            child  : Text(StringManager.exit.tr(),style:const TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 16),))
                      ],
                    ),
                  ))  ,
            ],
          ),
        )
    );
  }
}
