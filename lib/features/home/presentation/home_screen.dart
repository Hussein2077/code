import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/pusher_service.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/update_screen.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/widgets/group_chat_counter_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/home_show_case.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/item_widget_for_cache.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/host_time_on_mic_bloc/host_on_mic_time_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/host_time_on_mic_bloc/host_on_mic_time_state.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'widget/body/home_body.dart';
import 'widget/header/cache_data_widget.dart';
import 'widget/header/home_header.dart';

class HomeScreen extends StatefulWidget {
  static ValueNotifier<bool> rebuildGroupChatCounter = ValueNotifier<bool>(false);
  static ValueNotifier<int> groupChatCounter = ValueNotifier<int>(0);

  final bool? isChachGift;

  final bool? isCachFrame;

  final bool? isCachExtra;

  final bool? isCachEntro;

  final bool? isCachEmojie;

  final bool? isUpdate;

  final Uri? actionDynamicLink;

  const HomeScreen({this.isCachFrame,
    this.isUpdate,
    this.isCachExtra,
    this.isChachGift,
    this.isCachEntro,
    this.isCachEmojie,
    this.actionDynamicLink,
    super.key});

  static PusherService pusherService = PusherService();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController liveController;
  late bool isFirst;


  @override
  void initState() {
    liveController = TabController(length: 1, vsync: this);
    initlaizCachData();



    if (kDebugMode) {
      log('${widget.isChachGift}isChachGift');
      log('${widget.isCachExtra}isCachExtra');
      log('${widget.isCachFrame}isCachFrame');
      log('${widget.isCachEntro}isCachEntro');
      log('${widget.isCachEmojie}isCachEmojie');
    }
    if ((widget.isUpdate ?? false)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return const Material(
                  color: Colors.transparent,
                  child: UpdateScreen(isForceUpdate: false));
            });
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      MainScreen.isHomeShowCaseFirst = await Methods.instance.getHomeShowCase();
      if (((widget.isChachGift ?? false) ||
          (widget.isCachExtra ?? false) ||
          (widget.isCachFrame ?? false) ||
          (widget.isCachEntro ?? false) ||
          (widget.isCachEmojie ?? false)) &&
          MainScreen.isHomeShowCaseFirst) {
        Future.delayed(const Duration(seconds: 2), () {
          WidgetsBinding.instance.addPostFrameCallback(
                  (_) =>
                  ShowCaseWidget.of(context).startShowCase([homeCacheKey]));
        });
      }
    });


      handleDeepLink(widget.actionDynamicLink);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<HostOnMicTimeBloc, HostOnMicTimeState>(
      listener: (context, state) {
        if (state is HostOnMicTimeSucssesState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(successSnackBar(context, state.messsage));
        }
      },
      child: Scaffold(
        body: ScreenColorBackGround(
          color: ColorManager.mainColorList,
          child: Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 3.6,
              ),
              Stack(
                  children: [
                    Positioned(
                      right: ConfigSize.screenWidth! * .45,
                      child: HomeShowCaseWidget(
                        globalKey: homeCacheKey,
                        textInContainer: StringManager.tabToLoadData.tr(),
                        child: const SizedBox(),
                      ),
                    ),
                    HomeHeader(
                      liveController: liveController,
                    ),
                  ],
                ),
              HomeBody(liveController: liveController),
            ],
          ),
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: HomeScreen.rebuildGroupChatCounter,
          builder: (context, isShow, _) {
            if (isShow) {
              return InkWell(
                onTap: () {

                 Navigator.pushNamed(context, Routes.groupChatScreen);
                },
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.groupChatScreen);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: ConfigSize.defaultSize! * 3),
                        width: ConfigSize.defaultSize! * 5,
                        height: ConfigSize.defaultSize! * 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ConfigSize.defaultSize! * 5),
                          gradient: const LinearGradient(
                              colors: ColorManager.mainColorList),
                        ),
                        child: Image.asset(
                          AssetsPath.groupChat,
                          color: Colors.white,
                          scale: 2.5,
                        ),
                      ),
                    ),
                    const GroupChatCounterWidget()
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.groupChatScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: ConfigSize.defaultSize! * 3),
                  width: ConfigSize.defaultSize! * 5,
                  height: ConfigSize.defaultSize! * 5,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 5),
                    gradient: const LinearGradient(
                        colors: ColorManager.mainColorList),
                  ),
                  child: Image.asset(
                    AssetsPath.groupChat,
                    color: Colors.white,
                    scale: 2.5,
                  ),

                ),
              );
            }
          },
        ),
      ),
    );

  }

  initlaizCachData(){


      if (true){
        CacheDataWidget.cacheData.putIfAbsent(StringManager.lastTimeCacheGift,() => ItemWidget(
            text: StringManager.cacheGift.tr(), iconData: Icons.card_giftcard));
      }

      if (true){
        CacheDataWidget.cacheData.putIfAbsent(StringManager.lastTimeCacheExtra,() => ItemWidget(
            text: StringManager.cacheExtra.tr(), iconData: Icons.mobile_screen_share_rounded));
      }

      if (true){
        CacheDataWidget.cacheData.putIfAbsent(StringManager.lastTimeCacheExtra,
                () =>  ItemWidget(
            text: StringManager.cacheFrame.tr(), iconData: Icons.filter_frames) );

      }
      if (true){
        CacheDataWidget.cacheData.putIfAbsent(StringManager.lastTimeCacheEntro,
                () =>    ItemWidget(
                    text: StringManager.cacheIntro.tr(), iconData: Icons.arrow_circle_up)  );

      }

      if (true){
        CacheDataWidget.cacheData.putIfAbsent(StringManager.lastTimeCacheEmojie,
                () =>     ItemWidget(
                    text: StringManager.cacheEmoji.tr(), iconData: Icons.emoji_emotions_outlined)  );

      }
      CacheDataWidget.notifierCacheData.value = CacheDataWidget.notifierCacheData.value+1;


  }

  Future<void> handleDeepLink(Uri? data) async {
    final Uri? deepLink = data;
    final String? action = deepLink?.queryParameters['action'];

    if (action == 'enter_room') {
      final String? ownerId = deepLink?.queryParameters['owner_id'];
      final String? password = deepLink?.queryParameters['password'];
      enterRoomDynamicLink(password: password, ownerId: ownerId);
    } else if (action == 'visit_user') {
      final String? userId = deepLink?.queryParameters['user_id'];
      visitUserProfileDynamicLink(userId: userId);
    }
  }

  void enterRoomDynamicLink({String? password, String? ownerId}) async {
    if (password == '1') {
      await Methods.instance.checkIfRoomHasPassword(
          myData: MyDataModel.getInstance(),
          context: context,
          hasPassword: password == '1',
          ownerId: ownerId!);
    } else {
      Navigator.pushNamed(context, Routes.roomHandler,
          arguments: RoomHandlerPramiter(
              ownerRoomId: ownerId!, myDataModel: MyDataModel.getInstance()));
    }
  }

  void visitUserProfileDynamicLink({String? userId}) {
    Methods.instance.userProfileNvgator(context: context, userId: userId);
  }


}

