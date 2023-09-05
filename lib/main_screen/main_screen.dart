
import 'dart:developer';

import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/chat/persentation/chat_screen.dart';
import 'package:tik_chat_v2/features/following/persentation/following_live_screen.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_bloc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_event.dart';
import 'package:tik_chat_v2/features/home/presentation/home_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_body.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/country_dilog.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/profile_screen.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';

import '../core/resource_manger/asset_path.dart';
import 'widget/bottom_bar_widget.dart';

class MainScreen extends StatefulWidget {
  final bool? isChachGift;

  final bool? isCachFrame;

  final bool? isCachExtra;

  final bool? isCachEntro;

  final bool? isCachEmojie;

  final bool? isUpdate;

  static ValueNotifier<bool> iskeepInRoom = ValueNotifier<bool>(false);
  static int initPage = 0;
  static EnterRoomModel? roomData;
  static String reelId = '' ;

  const MainScreen(
      {this.isCachFrame,
      this.isUpdate,
      this.isCachExtra,
      this.isChachGift,
      this.isCachEntro,
      this.isCachEmojie,
      super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool isFirst = true;

  late final AnimationController animationController;

  @override
  void initState() {
    initDynamicLinks();
    listenToInternet();
    initPusher();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
      Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BottomNavLayout(
          pages: [
            (_) => HomeScreen(
                  isCachExtra: widget.isCachExtra,
                  isCachFrame: widget.isCachFrame,
                  isChachGift: widget.isChachGift,
                  isUpdate: widget.isUpdate,
                  isCachEmojie: widget.isCachEmojie,
                  isCachEntro: widget.isCachEntro,
                ),
            (_) => const ReelsScreen(),
            (_) => const FollowingLiveScreen(),
            (_) => const ChatScreen(),
            (_) => const ProfileScreen(),
          ],
          bottomNavigationBar: (currentIndex, onTap) => BottomBarWidget(
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          savePageState: true,
          lazyLoadPages: true,
          pageStack: ReorderToFrontPageStack(initialPage: MainScreen.initPage),
          extendBody: false,
          resizeToAvoidBottomInset: true,
          pageTransitionData: null,
        ),
      ),
      ValueListenableBuilder<bool>(
          valueListenable: MainScreen.iskeepInRoom,
          builder: (BuildContext context, bool value, Widget? child) {
            if (value) {
              return DraggableFloatWidget(
                config: const DraggableFloatWidgetBaseConfig(
                  initPositionYInTop: false,
                  initPositionYMarginBorder: 50,
                  borderTopContainTopBar: true,
                  borderBottom: 30,
                ),
                onTap: () {
                  RoomScreen.outRoom = false;
                  Navigator.pushNamed(context, Routes.roomScreen,
                      arguments: RoomPramiter(
                          roomModel: MainScreen.roomData!,
                          myDataModel: MyDataModel.getInstance(),
                          isHost: MyDataModel.getInstance().id.toString() ==
                              MainScreen.roomData!.ownerId.toString()));
                },
                child: Stack(
                  children: [
                    RotationTransition(
                        turns: animationController,
                        child: UserImage(
                          imageSize: ConfigSize.defaultSize! * 14,
                          image: MainScreen.roomData!.roomCover!,
                        )),
                    GestureDetector(
                      onTap: () async {
                        bottomDailog(
                            context: context,
                            widget: InkWell(
                                onTap: () {},
                                child: TransparentLoadingWidget(
                                  height: ConfigSize.defaultSize!*2,
                                  width: ConfigSize.defaultSize!*7.2,
                                )));

                        await Methods().exitFromRoom(
                            MainScreen.roomData!.ownerId.toString());
                        Navigator.pop(context);
                        MainScreen.iskeepInRoom.value = false;
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            CupertinoIcons.clear,
                            color: Colors.white,
                            size: AppPadding.p10,
                          )),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          })
    ]);
  }

  listenToInternet() {
    Connectivity().onConnectivityChanged.listen((event) {

      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        if (!isFirst) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          BlocProvider.of<GetFollwersRoomBloc>(context)
              .add(const GetFollwersRoomEvent(type: "5"));
          BlocProvider.of<GetRoomsBloc>(context)
              .add(GetRoomsEvent(typeGetRooms: TypeGetRooms.popular));
          AduioBody.type = StringManager.popular;
          AduioBody.countryId = null;
          CountryDialog.flag = AssetsPath.fireIcon;
          CountryDialog.name = StringManager.popular;
          CountryDialog.selectedCountry.value =
              !CountryDialog.selectedCountry.value;
        }
        isFirst = false;
      } else if (event == ConnectivityResult.none) {
        errorToast(
            context: context, title: StringManager.checkYourInternet.tr());
      }
    });
  }

  initDynamicLinks() async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks
        .instance.getInitialLink();
    log('actio');
    if(initialLink != null){
      log('actio2');
      handleDeepLink(initialLink);
    }
    FirebaseDynamicLinks.instance.onLink;
  }

  void handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data.link;
    final String? action = deepLink.queryParameters['action'];
    final String? ownerId = deepLink.queryParameters['owner_id'];
    final String? password = deepLink.queryParameters['password'];
    final String? userId = deepLink.queryParameters['owner_id'];
    final String? reelId = deepLink.queryParameters['reel_id'];
    log('action$action');
    if(action =='enter_room'){
      enterRoomDynamicLink(password: password, ownerId:ownerId );
    }else if (action =='visit_user'){
      visitUserProfileDynamicLink(userId: userId) ;
    }else if (action =='show_reel'){
      showReelDynamicLink(reelId:reelId);
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

  void showReelDynamicLink({String? reelId}){
    MainScreen.initPage =1 ;
    MainScreen.reelId = reelId??'' ;

  }

  void initPusher()async {
    HomeScreen.pusherService.initPusher(
        "9bfa0b56e375267a8f59","dragon-chat-app.com", 6001, "mt1");
  }
}
