// Dart imports:
import 'dart:async';
import 'dart:core';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/background.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/foreground.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/seat_container.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/bottom_bar.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/message/view.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/pop_up_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/live_duration_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/plugins.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_controller.dart';
//import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/minimizing/prebuilt_data.dart';

/// @nodoc
/// user and sdk should be login and init before page enter
class ZegoLivePage extends StatefulWidget {
  const ZegoLivePage({
    Key? key,
    this.prebuiltController,
    required this.appID,
    required this.appSign,
    required this.userID,
    required this.userName,
    required this.liveID,
    required this.config,
    required this.seatManager,
    required this.connectManager,
    required this.popUpManager,
    required this.liveDurationManager,
     this.popUpWidget,
   // required this.prebuiltAudioRoomData,
    required this.roomData ,
    this.plugins,
  }) : super(key: key);

  final int appID;
  final String appSign;

  final String userID;
  final String userName;

  final String liveID;
  final  EnterRoomModel  roomData  ;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;
  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
  final ZegoPopUpManager popUpManager;
  final ZegoLiveDurationManager liveDurationManager;
  final ZegoLiveAudioRoomController? prebuiltController;
  final ZegoPrebuiltPlugins? plugins;
  final Widget? popUpWidget ;
 // final ZegoUIKitPrebuiltLiveAudioRoomData prebuiltAudioRoomData;
  static ValueNotifier<int> editAudioVideoContainer = ValueNotifier<int>(0);

  @override
  State<ZegoLivePage> createState() => ZegoLivePageState();
}

/// @nodoc
class ZegoLivePageState extends State<ZegoLivePage>
    with SingleTickerProviderStateMixin {
  /// had sort the host be first
  bool audioVideoContainerHostHadSorted = false;

  List<StreamSubscription<dynamic>?> subscriptions = [];

  @override
  void initState() {
    super.initState();

    subscriptions.add(ZegoUIKit()
        .getTurnOnYourMicrophoneRequestStream()
        .listen(onTurnOnYourMicrophoneRequest));
  }

  @override
  void dispose() {
    super.dispose();

    for (final subscription in subscriptions) {
      subscription?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () async {
          MainScreen.iskeepInRoom.value = false;
          MainScreen.roomData = widget.roomData;
          MainScreen.iskeepInRoom.value = true;
          Navigator.pop(context);
          RoomScreen.outRoom = true;
          return true ;
        },
        child: ZegoScreenUtilInit(
          designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return clickListener(
              child: LayoutBuilder(builder: (context, constraints) {
                return Stack(
                  children: [
                    background(context, constraints.maxHeight),
                    messageList(),

                    ValueListenableBuilder(
                        valueListenable: ZegoLivePage.editAudioVideoContainer,
                        builder: (context,update,_){
                          return  audioVideoContainer(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ) ;
                        })   ,
                   // topBar(),
                    bottomBar(),
                    viewbackground(context, constraints.maxHeight),
                  ],
                );
              }),
            );
          },
        ),
      ),
    );
  }

  Widget clickListener({required Widget child}) {
    return GestureDetector(
      onTap: () {
        /// listen only click event in empty space
      },
      child: Listener(
        ///  listen for all click events in current view, include the click
        ///  receivers(such as button...), but only listen
        child: AbsorbPointer(
          absorbing: false,
          child: child,
        ),
      ),
    );
  }

  Widget background(BuildContext context, double height) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: 750.zW,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xffF4F4F6),
        ),
        child: widget.config.background,
      ),
    );
  }

  Widget viewbackground(BuildContext context, double height) {
    return widget.config.viewbackground ?? Container();
  }

  Widget audioVideoContainer(double maxWidth, double _maxHeight) {
    var maxHeight = _maxHeight - 169.zR; // top position
    maxHeight -= 124.zR; // bottom bar

    var scrollable = false;
    final fixedRow = widget.config.layoutConfig.rowConfigs.length;
    var containerHeight = seatItemHeight * fixedRow +
        widget.config.layoutConfig.rowSpacing * (fixedRow - 1);
    if (containerHeight > maxHeight) {
      containerHeight = maxHeight;
      scrollable = true;
    }

    final seatContainer = ZegoSeatContainer(
      seatManager: widget.seatManager,
      layoutConfig: widget.config.layoutConfig,
      foregroundBuilder: (
        BuildContext context,
        Size size,
        ZegoUIKitUser? user,
        Map<String, dynamic> extraInfo,
      ) {
        return  ValueListenableBuilder(
            valueListenable: PkController.showPK,
            builder: (context,isShowPK,_){
              return  ZegoSeatForeground(
                user: user,
                extraInfo: extraInfo,
                size: size,
                seatManager: widget.seatManager,
                connectManager: widget.connectManager,
                config: widget.config,
                prebuiltController: widget.prebuiltController,
                popUpManager: widget.popUpManager,
                roomData: widget.roomData,
                isHost: widget.userID == widget.roomData.ownerId.toString(),
                popUpWidget: widget.popUpWidget,

              );
            });



      },
      backgroundBuilder: (
        BuildContext context,
        Size size,
        ZegoUIKitUser? user,
        Map<String, dynamic> extraInfo,
      ) {
        return ZegoSeatBackground(
          user: user,
          extraInfo: extraInfo,
          size: size,
          seatManager: widget.seatManager,
          config: widget.config,
        );
      },
     avatarBuilder: widget.config.seatConfig.avatarBuilder,
    );

    return Positioned(
      top:RoomScreen.layoutMode==LayoutMode.cinemaMode?680.zR :190.zR,
      child: SizedBox(
        width: maxWidth - 20.zW ,
        height: RoomScreen.layoutMode == LayoutMode.hostTopCenter
            ? containerHeight
            : containerHeight + 40.zH,
        child: scrollable
            ? CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: seatContainer,
                  ),
                ],
              )
            : seatContainer,
      ),
    );
  }



  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ZegoBottomBar(
        height: 124.zR,
        buttonSize: zegoLiveButtonSize,
        config: widget.config,
        seatManager: widget.seatManager,
        connectManager: widget.connectManager,
        popUpManager: widget.popUpManager,
        prebuiltController: widget.prebuiltController,
        isPluginEnabled: widget.plugins?.isEnabled ?? false,
        avatarBuilder: widget.config.seatConfig.avatarBuilder,
        //prebuiltData: widget.prebuiltAudioRoomData,
        roomData: widget.roomData,
      ),
    );
  }

  Widget messageList() {

    if (!widget.config.inRoomMessageViewConfig.visible) {
      return Container();
    }
     return ValueListenableBuilder(
    valueListenable: PkController.showPK,
    builder: (context,isShowPk,_){
      var listSize = RoomScreen.layoutMode == LayoutMode.hostTopCenter?
      isShowPk ?  Size(
        750.zR, 485.zR,
      ):
      Size(700.zR, 550.zR,
      ) :Size(750.zW, 435.zH,
      );
      if (listSize.width < 54.zR) {
        listSize = Size(54.zR, listSize.height);
      }
      if (listSize.height < 40.zR) {
        listSize = Size(listSize.width, 40.zR);
      }
      return Positioned(
        right: widget.config.inRoomMessageConfig.bottomLeft?.dx ?? 0,
        bottom: 124.zR + (widget.config.inRoomMessageConfig.bottomLeft?.dy ?? 0),
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(listSize),
          child: ZegoInRoomLiveMessageView(
            config: widget.config.inRoomMessageViewConfig,
            avatarBuilder: widget.config.seatConfig.avatarBuilder,
            room: widget.roomData,
          ),
        ),
      );
    });

  }



  Future<void> onTurnOnYourMicrophoneRequest(
      ZegoUIKitReceiveTurnOnLocalMicrophoneEvent event) async {
    ZegoLoggerService.logInfo(
      'onTurnOnYourMicrophoneRequest, event:$event',
      tag: 'live audio',
      subTag: 'live page',
    );

    final canMicrophoneTurnOnByOthers = await widget
            .config.onMicrophoneTurnOnByOthersConfirmation
            ?.call(context) ??
        false;
    ZegoLoggerService.logInfo(
      'canMicrophoneTurnOnByOthers:$canMicrophoneTurnOnByOthers',
      tag: 'live audio',
      subTag: 'live page',
    );
    //todo add this condation to handle mute user in minimize
    if (canMicrophoneTurnOnByOthers ) {
      ZegoUIKit().turnMicrophoneOn(true);
    }
  }
}
