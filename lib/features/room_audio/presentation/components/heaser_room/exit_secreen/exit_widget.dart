import 'dart:developer';
import 'dart:ui' as ui;

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
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
    return  BlurryContainer(
        width: ConfigSize.screenWidth,
        height: ConfigSize.screenHeight,
        blur: 2,
        child: Directionality(
          textDirection:ui.TextDirection.ltr,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(
                flex: 2,
              ),
              InkWell(
                onTap: () {

                  if (PkController.isPK.value == true) {
                    errorToast(
                        title: 'You Can\'t Save Room PK is Running',
                        context: context,
                        subTitle: '');
                  }
                  else {
                    MainScreen.iskeepInRoom.value = false;

                    MainScreen.roomData = widget.roomData;

                    MainScreen.iskeepInRoom.value = true;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    RoomScreen.outRoom = true;
                  }
                },
                child: Column(

                  children: [
                    Image.asset(AssetsPath.saveRoom, width:  ConfigSize.defaultSize!*10, height: ConfigSize.defaultSize!*10,

                    ),
                    Padding(padding:const EdgeInsets.all(8),
                      child: Text(StringManager.save.tr(),style:const TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 16),),
                    )
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: ()async{
                  MainScreen.iskeepInRoom.value=false;
                  Navigator.pop(context);
                  Navigator.pop(context);
                  await Methods.instance.exitFromRoom(widget.roomData.ownerId.toString(), context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AssetsPath.exitRoom, width:  ConfigSize.defaultSize!*10, height: ConfigSize.defaultSize!*10,),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(StringManager.exit.tr(),style:const TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontSize: 16),))
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        )
    );
  }
}
