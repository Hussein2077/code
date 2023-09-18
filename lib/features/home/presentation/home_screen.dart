import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
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
  final Uri?  actionDynamicLink ;
  const HomeScreen({
  this.isCachFrame,
  this.isUpdate,
  this.isCachExtra,
  this.isChachGift,
  this.isCachEntro,
  this.isCachEmojie,
  this.actionDynamicLink,
  super.key});
   static  PusherService pusherService =  PusherService();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController liveController;
  @override
  void initState() {

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



   Future.delayed(const Duration(seconds: 2),(){
  handleDeepLink(widget.actionDynamicLink);
});
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


  Future<void> handleDeepLink(Uri?  data) async {
    final Uri? deepLink = data;
    final String? action = deepLink?.queryParameters['action'];

    if(action =='enter_room'){
      final String? ownerId = deepLink?.queryParameters['owner_id'];
      final String? password = deepLink?.queryParameters['password'];
      enterRoomDynamicLink(password: password, ownerId:ownerId );
    }else if (action =='visit_user'){
      final String? userId = deepLink?.queryParameters['user_id'];
      visitUserProfileDynamicLink(userId: userId) ;
    }

  }

  void enterRoomDynamicLink({ String? password, String? ownerId })async {
    if(password=='1'){
      await  Methods().checkIfRoomHasPassword(
          myData :MyDataModel.getInstance() ,
          context: context,
          hasPassword: password=='1' ,
          ownerId: ownerId!);
    }else{
      Navigator.pushNamed(context, Routes.roomHandler,
          arguments: RoomHandlerPramiter(ownerRoomId: ownerId!,
              myDataModel: MyDataModel.getInstance())) ;
    }
  }

  void visitUserProfileDynamicLink ({String? userId }){
    Methods().userProfileNvgator(context: context,userId:userId );
  }

}
