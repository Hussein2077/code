
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/service/pusher_service.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/update_screen.dart';
import 'widget/body/home_body.dart';
import 'widget/header/home_header.dart';

class HomeScreen extends StatefulWidget {
  final bool? isChachGift ;
  final bool? isCachFrame ;
  final bool? isCachExtra ;
  final bool? isCachEntro ;
  final bool? isCachEmojie ;
  final bool? isUpdate ;
  const HomeScreen({
  this.isCachFrame,
  this.isUpdate,
  this.isCachExtra,
  this.isChachGift,
  this.isCachEntro,
  this.isCachEmojie,
  super.key});
   static  PusherService pusherService =  PusherService();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController liveController;
  @override
  void initState() {

    // initPusher();
    liveController = TabController(length: 1, vsync: this);
    if((widget.isChachGift??false)){
      Methods().chachGiftInRoom();
    }
    if((widget.isCachExtra??false)){
      Methods().getAndLoadExtraData();
    }
    if((widget.isCachFrame??false)){
      Methods().getAndLoadFrames();
    }
    if((widget.isCachEntro??false)){
      Methods().getAndLoadEntro();
    }
    if((widget.isCachEmojie??false)){
      Methods().getAndLoadEmojie();
    }
    if((widget.isUpdate??false)){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
            barrierDismissible:true,
            context: context,
            builder: (BuildContext context) {
              return const  Material(
                  color: Colors.transparent,
                  child: UpdateScreen(isForceUpdate: false));
            });

      });
    }





    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenColorBackGround(
        color: ColorManager.mainColorList,
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 5,
            ),
            HomeHeader(
              liveController: liveController,
            ),
            
           HomeBody(liveController: liveController),
          ],
        ),
      ),
    );
  }



}
