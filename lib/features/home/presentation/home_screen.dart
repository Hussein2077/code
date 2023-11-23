
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/service/pusher_service.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/update_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_state.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/widgets/group_chat_counter_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

import 'widget/body/home_body.dart';
import 'widget/header/home_header.dart';

class HomeScreen extends StatefulWidget {
  static ValueNotifier<bool> rebuildGroupChatCounter = ValueNotifier<bool>(false);
  static ValueNotifier<int> groupChatCounter = ValueNotifier<int>(0);


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
      Methods.instance.chachGiftInRoom();
    }
    if((widget.isCachExtra??false)){
      Methods.instance.getAndLoadExtraData();
    }
    if((widget.isCachFrame??false)){
      Methods.instance.getAndLoadFrames();
    }
    if((widget.isCachEntro??false)){
      Methods.instance.getAndLoadEntro();
    }
    if((widget.isCachEmojie??false)){
      Methods.instance.getAndLoadEmojie();
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
    return BlocConsumer<AddInfoBloc, AddInfoState>(
  listener: (context, state) {
    if (state is AddInfoSuccesMessageState) {
      BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
      Navigator.pop(context);
    } else if (state is AddInfoErrorMessageState) {
     }

   },
  builder: (context, state) {
    return Scaffold(
      body: ScreenColorBackGround(
        color: ColorManager.mainColorList,
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 1.2,
            ),
            HomeHeader(
              liveController: liveController,
            ),
            HomeBody(liveController: liveController),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: HomeScreen.rebuildGroupChatCounter,
            builder: (context, isShow, _) {
          if(isShow){
          return  InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.groupChatScreen);

            },
            child: Stack(
              children: [
                InkWell(
                onTap: (){

                  Navigator.pushNamed(context, Routes.groupChatScreen);

          },
            child: Container(
              margin: EdgeInsets.only(bottom: ConfigSize.defaultSize! * 3),
              width: ConfigSize.defaultSize! * 5,
              height: ConfigSize.defaultSize! * 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    ConfigSize.defaultSize! * 5),
                gradient: const LinearGradient(
                    colors: ColorManager.mainColorList),
              ),
              child: Image.asset(AssetsPath.groupChat , color: Colors.white, scale: 2.5,),
            ),
          ),
                const GroupChatCounterWidget()
              ],

            ),
          );
          }else {
            return
              InkWell(
                onTap: (){

                  Navigator.pushNamed(context, Routes.groupChatScreen);

                },
                child: Container(
                  margin: EdgeInsets.only(bottom: ConfigSize.defaultSize! * 3),
                  width: ConfigSize.defaultSize! * 5,
                  height: ConfigSize.defaultSize! * 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        ConfigSize.defaultSize! * 5),
                    gradient: const LinearGradient(
                        colors: ColorManager.mainColorList),
                  ),
                  child: Image.asset(AssetsPath.groupChat , color: Colors.white, scale: 2.5,),


                  // IconButton(
                  //   icon: Icon(
                  //     Icons.edit,
                  //     color: Theme
                  //         .of(context)
                  //         .colorScheme
                  //         .background,
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, Routes.groupChatScreen);
                  //   },
                  // ),

                ),
              );
          }
            },
      ),
    );
  },
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
      await  Methods.instance.checkIfRoomHasPassword(
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
    Methods.instance.userProfileNvgator(context: context,userId:userId );
  }

}
