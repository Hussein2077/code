import 'dart:async';
import 'dart:developer';

import 'package:animated_icon/animated_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/update_screen.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/widgets/group_chat_counter_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/home_show_case.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/item_widget_for_cache.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/host_time_on_mic_bloc/host_on_mic_time_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/host_time_on_mic_bloc/host_on_mic_time_state.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'widget/body/home_body.dart';
import 'widget/header/home_header.dart';

class HomeScreen extends StatefulWidget {
  static ValueNotifier<bool> rebuildGroupChatCounter =
  ValueNotifier<bool>(false);
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
late  List<ItemWidget> items;
  @override
  void initState() {
    liveController = TabController(length: 1, vsync: this);
    items = [
      if (widget.isCachExtra ?? false)
        ItemWidget(
            text: StringManager.cacheGift.tr(), iconData: Icons.card_giftcard),
      if (widget.isCachExtra ?? false)
        ItemWidget(
            text: StringManager.cacheExtra.tr(), iconData: Icons.mobile_screen_share_rounded),
      if (widget.isCachFrame ?? false)
        ItemWidget(
            text: StringManager.cacheFrame.tr(), iconData: Icons.filter_frames),

      if (widget.isCachEntro ?? false)
        ItemWidget(
            text: StringManager.cacheIntro.tr(), iconData: Icons.arrow_circle_up),

      if (widget.isCachEmojie ?? false)
        ItemWidget(
            text: StringManager.cacheEmoji.tr(), iconData: Icons.emoji_emotions_outlined),

    ];
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

    Future.delayed(const Duration(seconds: 30), () {
      handleDeepLink(widget.actionDynamicLink);
    });
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
              StatefulBuilder(builder: (context, setState) {
                void onChangedCacheInDropDownHome(ItemWidget? value) {

                  if (value?.text == StringManager.cacheGift.tr()) {
                    Methods.instance.chachGiftInRoom();
                    setState(() {
                      items.removeWhere((element) => element.text==StringManager.cacheGift.tr());

                    });

                  } else if (value?.text ==  StringManager.cacheExtra.tr()) {

                    Methods.instance.getAndLoadExtraData();
                    setState(() {
                      items.removeWhere((element) => element.text==StringManager.cacheExtra.tr());
                    });
                  } else if (value?.text == StringManager.cacheFrame.tr()) {
                    Methods.instance.getAndLoadFrames();
                    setState(() {
                      items.removeWhere((element) => element.text==StringManager.cacheFrame.tr());
                    });
                  } else if (value?.text == StringManager.cacheIntro.tr()) {
                    Methods.instance.getAndLoadEntro();
                    setState(() {
                      items.removeWhere((element) => element.text==StringManager.cacheIntro.tr());
                    });
                  } else if (value?.text == StringManager.cacheEmoji.tr()) {

                    Methods.instance.getAndLoadEmojie();
                    setState(() {
                      items.removeWhere((element) => element.text==StringManager.cacheEmoji.tr());
                    });
                  }
                  sucssesToast(context: context, title: StringManager.dataLoaded.tr());
                }
                return Stack(
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
                      cacheButton: Visibility(
                        visible: items.isNotEmpty,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<ItemWidget>(
                            items: items
                                .map((item) =>
                                DropdownMenuItem(
                                  value: item,
                                  child:
                                  item,

                                ))
                                .toList(),
                            onChanged: (value) {


                              onChangedCacheInDropDownHome(value);
                            },
                            isExpanded: true,
                            hint: Text(
                              StringManager.cache.tr(),
                              style: TextStyle(
                                fontSize: ConfigSize.defaultSize!*1.2,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.whiteColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ConfigSize.defaultSize!),
                            ),
                            buttonWidth: ConfigSize.defaultSize! * 12,
                            dropdownWidth: ConfigSize.defaultSize! * 15,
                            icon: AnimateIcon(
                              key: UniqueKey(),
                              onTap: () {},
                              iconType: IconType.continueAnimation,
                              height: ConfigSize.defaultSize! * 4,
                              width: ConfigSize.defaultSize! * 4,
                              color: ColorManager.whiteColor,
                              animateIcon: AnimateIcons.cloud,
                            ),
                            offset: const Offset(25, 5),
                          ),
                        )
                      ),
                    ),
                  ],
                );
              }),
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
      ),
    );

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

