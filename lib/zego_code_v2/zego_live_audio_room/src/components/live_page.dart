// Dart imports:
import 'dart:async';
import 'dart:core';

// Flutter imports:
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

// Project imports:

import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/audio_video/background.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/audio_video/foreground.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/audio_video/seat_container.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/bottom_bar.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/message/in_room_live_commenting_view.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/top_bar.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/plugins.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import '../../../../features/room_audio/presentation/Room_Screen.dart';


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
    required this.roomData,
    required this.roomMode,
    required this.myDataModel,
    this.plugins,
  }) : super(key: key);

  final int appID;
  final String appSign;

  final String userID;
  final String userName;
  final MyDataModel myDataModel;

  final String liveID;
  final EnterRoomModel roomData;
  final LayoutMode roomMode;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;
  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
  final ZegoLiveAudioRoomController? prebuiltController;
  final ZegoPrebuiltPlugins? plugins;

  @override
  State<ZegoLivePage> createState() => ZegoLivePageState();
}

class ZegoLivePageState extends State<ZegoLivePage>
    with SingleTickerProviderStateMixin {
  /// had sort the host be first
  bool audioVideoContainerHostHadSorted = false;

  List<StreamSubscription<dynamic>?> subscriptions = [];

  @override
  void initState() {
    super.initState();
    if (!MainScreen.iskeepInRoom.value) {
      subscriptions.add(ZegoUIKit()
          .getTurnOnYourMicrophoneRequestStream()
          .listen(onTurnOnYourMicrophoneRequest));
    }
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
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async {
          MainScreen.roomData = widget.roomData;
          MainScreen.iskeepInRoom.value = true;
          Navigator.pop(context);
          RoomScreen.outRoom = true;
          return true;
        },
        child: ScreenUtilInit(
          designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return clickListener(
              child: LayoutBuilder(builder: (context, constraints) {
                return Stack(
                  children: [
                    background(context, constraints.maxHeight),

                   ValueListenableBuilder(
                      valueListenable: RoomScreen.editAudioVideoContainer,
                      builder: (context,update,_){
                        return  audioVideoContainer(
                          constraints.maxWidth,
                          constraints.maxHeight,
                        ) ;
                      }) ,
                    bottomBar(),
                    messageList(),
                    // to show entro  && gifts
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
        width: 750.w,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xffF4F4F6),
        ),
        child: widget.config.background,
      ),
    );
  }

  Widget viewbackground(BuildContext context, double height) {
    return Container(
      child: widget.config.viewbackground,
    );
  }

  Widget audioVideoContainer(double maxWidth, double _maxHeight) {
    var maxHeight = _maxHeight - 169.r; // top position
    maxHeight -= 124.r; // bottom bar

    var scrollable = false;
    final fixedRow = widget.config.layoutConfig.rowConfigs.length;
    var containerHeight = seatItemHeight * fixedRow +
        widget.config.layoutConfig.rowSpacing * (fixedRow - 1);
    if (containerHeight > maxHeight) {
      containerHeight = maxHeight;
      scrollable = true;
    }

    final seatContainer = ZegoSeatContainer(
      roomMode: widget.roomMode,
      seatManager: widget.seatManager,
      layoutConfig: widget.config.layoutConfig,
      foregroundBuilder: (
        BuildContext context,
        Size size,
        ZegoUIKitUser? user,
        Map<String, dynamic> extraInfo,
      ) {
        return  ValueListenableBuilder(valueListenable: RoomScreen.showPK,
            builder: (context,isShowPK,_){
            return  ZegoSeatForeground(
              user: user,
              extraInfo: extraInfo,
              size: size,
              seatManager: widget.seatManager,
              connectManager: widget.connectManager,
              config: widget.config,
              prebuiltController: widget.prebuiltController,
              roomData: widget.roomData,
              isHost: widget.userID == widget.roomData.ownerId.toString(),
              roomMode: widget.roomMode,
              myDataModel: widget.myDataModel, layoutMode: widget.roomMode,
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
          roomMode: widget.roomMode,
        );
      },
      sortAudioVideo: audioVideoViewSorter,
      avatarBuilder: widget.config.seatConfig.avatarBuilder,
    );
    https://tic-chat.saree3-app.com/storage/profile/5GfuZ94MLP.jpg
    return Positioned(
      top: 190.r,
      //left: 35.w,
      child: SizedBox(
        width: maxWidth,
        height: widget.roomMode == LayoutMode.hostTopCenter
            ? containerHeight
            : containerHeight + 40.h,
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

  List<ZegoUIKitUser> audioVideoViewSorter(List<ZegoUIKitUser> users) {
    return users;
  }

  Widget topBar() {
    return Positioned(
      left: 0,
      right: 0,
      top: 64.r,
      child: ValueListenableBuilder<ZegoUIKitRoomState>(
        valueListenable: ZegoUIKit().getRoomStateStream(),
        builder: (context, roomState, _) {
          return ZegoTopBar(
            config: widget.config,
            seatManager: widget.seatManager,
            translationText: widget.config.innerText,
          );
        },
      ),
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ValueListenableBuilder (
        valueListenable: RoomScreen.updatebuttomBar,
        builder: (context,edit,_){
          return  ZegoBottomBar(
            height: 124.r,
            buttonSize: zegoLiveButtonSize,
            config: widget.config,
            seatManager: widget.seatManager,
            connectManager: widget.connectManager,
            prebuiltController: widget.prebuiltController,
            isPluginEnabled: widget.plugins?.isEnabled ?? false,
            avatarBuilder: widget.config.seatConfig.avatarBuilder,
            roomData: widget.roomData,
            myDataModel : widget.myDataModel,
            layoutMode: widget.roomMode,
          ) ;
        },
      ),
    );
  }

  Widget messageList() {
    if (!widget.config.inRoomMessageViewConfig.visible) {
      return Container();
    }

    return  ValueListenableBuilder(valueListenable: RoomScreen.showPK,
        builder: (context,isShowPK,_){
          return  Positioned(
      left: 75.r,
      right: 20.r,
      bottom: 120.r,
      child: ConstrainedBox(
        constraints: widget.roomMode == LayoutMode.hostTopCenter
            ? isShowPK
                ? BoxConstraints.loose(Size(600.r, 485.r))
                : BoxConstraints.loose(Size(600.r, 550.r))
            : BoxConstraints.loose(Size(600.r, 435.r)),
        child: ZegoInRoomLiveCommentingView(
          room: widget.roomData,
          roomMode: widget.roomMode,
          itemBuilder: widget.config.inRoomMessageViewConfig.itemBuilder,
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
    if (canMicrophoneTurnOnByOthers) {
      ZegoUIKit().turnMicrophoneOn(true);
    }
  }
}
