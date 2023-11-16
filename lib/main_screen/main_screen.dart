import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/auth/data/model/third_party_auth_model.dart';
import 'package:tik_chat_v2/features/chat/user_chat/chat_page.dart';
import 'package:tik_chat_v2/features/following/persentation/following_live_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/home_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/profile_screen.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/main_screen/components/nav_bar/bottom_nav_layout.dart';
import 'package:tik_chat_v2/splash.dart';
import '../features/reels/persentation/reels_screen_taps.dart';
import 'widget/bottom_bar_widget.dart';

class MainScreen extends StatefulWidget {
  final bool? isChachGift;

  final bool? isCachFrame;

  final bool? isCachExtra;

  final bool? isCachEntro;

  final bool? isCachEmojie;

  final bool? isUpdate;

  final Uri? actionDynamicLink;

  static bool canNotPlayOutOfReelMainScreen = true ;

  static ValueNotifier<bool> iskeepInRoom = ValueNotifier<bool>(false);

  static EnterRoomModel? roomData;

  static String reelId = '';
  static String? momentId ;


  const MainScreen(
      {this.isCachFrame,
      this.isUpdate,
      this.isCachExtra,
      this.isChachGift,
      this.isCachEntro,
      this.isCachEmojie,
      this.actionDynamicLink,
      super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  bool isFirst = true;

  late final AnimationController animationController;

  @override
  void initState() {
    Methods.instance.getDependencies(context);

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
    return BlocListener<GetMyDataBloc, GetMyDataState>(
      listener: (context, state) {
        if (state is GetMyDataSucssesState) {
          if (state.myDataModel.profile!.age == 0 ||
              state.myDataModel.profile!.country == "") {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.addInfo, (route) => false,
                arguments: ThirdPartyAuthModel(
                  isBirthdayDateNotComplete:
                      state.myDataModel.profile!.country == "" ? true : false,
                  isAgeNotComplete:
                      state.myDataModel.profile!.age == 0 ? true : false,
                ));
          }
        }
      },
      child: WillPopScope(
          onWillPop: () async {
            // showExitDialog() ;
            return false;
          },
          child: Stack(children: [
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
                        actionDynamicLink: widget.actionDynamicLink,
                      ),
                  (_) => const ReelsScreenTaps(),
                  (_) =>  const SafeArea(child: ChatPage()),
                  (_) => const FollowingLiveScreen(),
                  (_) => const MomentScreen(),
                  (_) => const ProfileScreen(),

                ],
                bottomNavigationBar: (currentIndex, onTap) => BottomBarWidget(
                  currentIndex: currentIndex,
                  onTap: onTap,
                ),
                savePageState: true,
                lazyLoadPages: true,
                pageStack: ReorderToFrontPageStack(initialPage: SplashScreen.initPage),
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
                                isHost: MyDataModel.getInstance()
                                        .id
                                        .toString() ==
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
                                  widget: TransparentLoadingWidget(
                                    height: ConfigSize.defaultSize! * 2,
                                    width: ConfigSize.defaultSize! * 7.2,
                                  ));

                              await Methods.instance.exitFromRoom(
                                  MainScreen.roomData!.ownerId.toString(), context);
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
          ])),
    );
  }

  listenToInternet() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        if (!isFirst) {
          Methods.instance.getDependencies(context);
        }
        isFirst = false;
      } else if (event == ConnectivityResult.none) {
        errorToast(
            context: context, title: StringManager.checkYourInternet.tr());
      }
    });
  }

  void initPusher() async {
    HomeScreen.pusherService.initPusher("4fb9e086738157749a5a", "eu");
  }
}
