// Dart imports:
import 'dart:async';
import 'dart:core';
import 'dart:developer';

// Flutter imports:
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_controller.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/exist_room_uc.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_signaling/zego_uikit_signaling_plugin.dart';












// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/dialogs.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/live_page.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/permissions.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/toast.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/plugins.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import '../../zego_uikit/zego_uikit.dart';


class ZegoUIKitPrebuiltLiveAudioRoom extends StatefulWidget {
  const ZegoUIKitPrebuiltLiveAudioRoom({
    Key? key,
    required this.appID,
    required this.roomMode,
    required this.appSign,
    required this.userID,
    required this.userName,
    required this.roomID,
    required this.config,
    required this.roomData,
    required this.myDataModel,
    this.appDesignSize,
    this.controller,
  }) : super(key: key);

  /// you need to fill in the appID you obtained from console.zegocloud.com
  final int appID;

  /// for Android/iOS
  /// you need to fill in the appID you obtained from console.zegocloud.com
  final String appSign;

  /// local user info
  final String userID;
  final String userName;
  final MyDataModel myDataModel;

  /// You can customize the liveName arbitrarily,
  /// just need to know: users who use the same liveName can talk with each other.
  final String roomID;
  final EnterRoomModel roomData ;
  final LayoutMode roomMode ;
  final ZegoLiveAudioRoomController? controller;
  final Size? appDesignSize;
  final ZegoUIKitPrebuiltLiveAudioRoomConfig config;

  @override
  State<ZegoUIKitPrebuiltLiveAudioRoom> createState() =>
      ZegoUIKitPrebuiltLiveAudioRoomState();
}

class ZegoUIKitPrebuiltLiveAudioRoomState
    extends State<ZegoUIKitPrebuiltLiveAudioRoom> with WidgetsBindingObserver {
  static     ZegoPrebuiltPlugins? plugins;
  static      ZegoLiveSeatManager? seatManager;
  static      ZegoLiveConnectManager? connectManager;
  static  late  ZegoUIKitPrebuiltLiveAudioRoomConfig  zegoUIKitPrebuiltLiveAudioRoomConfig     ;

  List<StreamSubscription<dynamic>?> subscriptions = [];

  late NavigatorState navigatorState;

  @override
  void initState() {
    super.initState();
    if(!MainScreen.iskeepInRoom.value){
      zegoUIKitPrebuiltLiveAudioRoomConfig = widget.config ;
      correctConfigValue();

      WidgetsBinding.instance.addObserver(this);

      ZegoUIKit().getZegoUIKitVersion().then((version) {
        ZegoLoggerService.logInfo(
          'version: zego_uikit_prebuilt_live_audio_room: 2.2.3; $version',
          tag: 'audio room',
          subTag: 'prebuilt',
        );
      });

      subscriptions
        ..add(ZegoUIKit().getUserJoinStream().listen(onUserJoined))
        ..add(ZegoUIKit().getUserLeaveStream().listen(onUserLeave));

      plugins = ZegoPrebuiltPlugins(
        appID: widget.appID,
        appSign: widget.appSign,
        userID: widget.userID,
        userName: widget.userName,
        roomID: widget.roomID,
        plugins: [ZegoUIKitSignalingPlugin()],
        onPluginReLogin: () {
          seatManager?.queryRoomAllAttributes(withToast: false).then((value) {
            seatManager?.initRoleAndSeat();
          });
        },
      );
      seatManager = ZegoLiveSeatManager(
        localUserID: widget.userID,
        roomID: widget.roomID,
        plugins: plugins!,
        config: widget.config,
        prebuiltController: widget.controller,
        innerText: widget.config.innerText,
        contextQuery: () {
          return context;
        }, ownerId:widget.roomData.ownerId.toString(),
        isHost: widget.roomData.ownerId.toString() == widget.myDataModel.id.toString(),
      );
      connectManager = ZegoLiveConnectManager(
        config: widget.config,
        seatManager: seatManager!,
        prebuiltController: widget.controller,
        innerText: widget.config.innerText,
        contextQuery: () {
          return context;
        }, roomData: widget.roomData,
      );
      seatManager?.setConnectManager(connectManager!);

      widget.controller?.initByPrebuilt(
        connectManager: connectManager,
        seatManager: seatManager,
      );

      initToast();

      plugins?.init().then((value) {
        checkPermissions().then((value) {
          ZegoLoggerService.logInfo(
            'plugins init done',
            tag: 'audio room',
            subTag: 'prebuilt',
          );
          seatManager?.init().then((value) {
            ZegoLoggerService.logInfo(
              'seat manager init done',
              tag: 'audio room',
              subTag: 'prebuilt',
            );
            seatManager?.initRoleAndSeat();

            connectManager?.init();
          });
        });
      });
      initContext();
    }

  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);

   //  widget.controller?.uninitByPrebuilt();
   //
   //  // connectManager?.uninit();
   //  // seatManager?.uninit();
   //  // plugins?.uninit();
   //
   // // uninitContext();
   //
   //  for (final subscription in subscriptions) {
   //    subscription?.cancel();
   //  }
   //
   //  if (widget.appDesignSize != null) {
   //    ScreenUtil.init(
   //      navigatorState.context,
   //      designSize: widget.appDesignSize!,
   //    );
   //  }
  }

  @override
  void didChangeDependencies() {
    navigatorState = Navigator.of(context);
    super.didChangeDependencies();
  }






  @override
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    super.didChangeAppLifecycleState(state);

    ZegoLoggerService.logInfo(
      'didChangeAppLifecycleState $state',
      tag: 'audio room',
      subTag: 'prebuilt',
    );

    switch (state) {
      case AppLifecycleState.resumed:
        // plugins?.tryReLogin();
        // RoomScreen.userOnMics.value.putIfAbsent(int.parse( widget.userID),
        //         () => ZegoUIKitUser(id: widget.userID, name: widget.userName)) ;
        // if(!RoomScreen.outRoom){
        //   BlocProvider.of<RoomBloc>(context).add(EnterRoomEvent(ownerId: widget.roomData.ownerId.toString()
        //       , roomPassword: '',sendTpZego: false,ignorPassword: false , isVip:widget.userData.vip1?.level??0  ));
        //   for(var e in  RoomScreen.userOnMics.value.entries){
        //     if(e.value.id == widget.userData.id){
        //       BlocProvider.of<OnRoomBloc>(context).add(UpMicEvent(ownerId: widget.roomData.ownerId.toString(),
        //           userId:widget.userData.id.toString() , position:e.key.toString()));
        //     }
        //   }
        // }
        break;
      case AppLifecycleState.inactive:
        break ;
      case AppLifecycleState.paused:
        break ;
      case AppLifecycleState.detached:
         Methods().exitFromRoom(widget.roomData.ownerId.toString()) ;
        ExistroomUC e = ExistroomUC( roomRepo: getIt());
        await  e.call(widget.roomData.ownerId.toString());
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    widget.config.onLeaveConfirmation ??= onLeaveConfirmation;

    return ZegoLivePage(
      appID: widget.appID,
      appSign: widget.appSign,
      userID: widget.userID,
      userName: widget.userName,
      liveID: widget.roomID,
      config: widget.config,
      plugins: plugins,
      seatManager: seatManager!,
      connectManager: connectManager!,
      prebuiltController: widget.controller,
      roomData:  widget.roomData,
      roomMode: widget.roomMode, myDataModel: widget.myDataModel,
    );
  }

  void correctConfigValue() {
    if (widget.config.bottomMenuBarConfig.maxCount > 5) {
      widget.config.bottomMenuBarConfig.maxCount = widget.config.bottomMenuBarConfig.maxCount ;
      ZegoLoggerService.logInfo(
        "menu bar buttons limited count's value is exceeding the maximum limit",
        tag: 'audio room',
        subTag: 'prebuilt',
      );
    }

    for (final rowConfig in widget.config.layoutConfig.rowConfigs) {
      if (rowConfig.count < 1) {
        rowConfig.count =  rowConfig.count;
        ZegoLoggerService.logInfo(
          'config column count(${rowConfig.count}) is small than 0, set to 1',
          tag: 'audio room',
          subTag: 'prebuilt',
        );
      }
      if (rowConfig.count > 4) {
        rowConfig.count = 4;
        ZegoLoggerService.logInfo(
          'config column count(${rowConfig.count}) is bigger than 4, set to 4',
          tag: 'audio room',
          subTag: 'prebuilt',
        );
      }
    }
    if (widget.config.layoutConfig.rowSpacing < 0) {
      widget.config.layoutConfig.rowSpacing = 0;
      ZegoLoggerService.logInfo(
        'config row spacing(${widget.config.layoutConfig.rowSpacing}) '
        'is not valid, set to 0',
        tag: 'audio room',
        subTag: 'prebuilt',
      );
    }

    final totalSeatCount = widget.config.layoutConfig.rowConfigs
        .fold<int>(0, (totalCount, rowConfig) => totalCount + rowConfig.count);
    final isSeatIndexValid = widget.config.takeSeatIndexWhenJoining >= 0 &&
        widget.config.takeSeatIndexWhenJoining < totalSeatCount;
    if (!isSeatIndexValid) {
      ZegoLoggerService.logInfo(
        'config seat index is not valid, change role to audience '
        'and seat index set to -1',
        tag: 'audio room',
        subTag: 'prebuilt',
      );
      widget.config.role = ZegoLiveAudioRoomRole.audience;
      widget.config.takeSeatIndexWhenJoining = -1;
    }
    if (widget.config.role == ZegoLiveAudioRoomRole.audience &&
        isSeatIndexValid) {
      ZegoLoggerService.logInfo(
        'audience config should not on seat default, set to -1',
        tag: 'audio room',
        subTag: 'prebuilt',
      );
      widget.config.takeSeatIndexWhenJoining = -1;
    }
    if (ZegoLiveAudioRoomRole.host != widget.config.role &&
        widget.config.hostSeatIndexes
            .contains(widget.config.takeSeatIndexWhenJoining)) {
      ZegoLoggerService.logInfo(
        "config ${widget.config.role.toString()}'s index is not valid, "
        'change role to audience and seat index set to -1',
        tag: 'audio room',
        subTag: 'prebuilt',
      );
      widget.config.role = ZegoLiveAudioRoomRole.audience;
      widget.config.takeSeatIndexWhenJoining = -1;
    }

    ZegoLoggerService.logInfo(
      'layout config:${widget.config.layoutConfig.toString()}',
      tag: 'audio room',
      subTag: 'prebuilt',
    );
  }

  Future<void> checkPermissions() async {
    var isMicrophoneGranted = true;
    if (widget.config.turnOnMicrophoneWhenJoining) {
      isMicrophoneGranted = await requestPermission(Permission.microphone);
    }

    if (!isMicrophoneGranted) {
      await showAppSettingsDialog(
        context,
        widget.config.innerText.microphonePermissionSettingDialogInfo,
      );
    }
  }

  void initContext() {
    assert(widget.userID.isNotEmpty);
    assert(widget.userName.isNotEmpty);
    assert(widget.appID > 0);
    assert(widget.appSign.isNotEmpty);

    ZegoUIKit().login(widget.userID, widget.userName);

    ZegoUIKit()
        .init(
          appID: widget.appID,
          appSign: widget.appSign,
          scenario: ZegoScenario.Broadcast,
        )
        .then(onContextInit);
  }

  void onContextInit(_) {
    ZegoUIKit()
     // ..turnCameraOn(false)
      ..turnMicrophoneOn(widget.config.turnOnMicrophoneWhenJoining)
      ..setAudioOutputToSpeaker(widget.config.useSpeakerWhenJoining)
      ..setAudioVideoResourceMode(ZegoAudioVideoResourceMode.RTCOnly);

    ZegoUIKit().joinRoom(widget.roomID).then((result) async {
      await onRoomLogin(result);
    });
  }

  Future<void> onRoomLogin(ZegoRoomLoginResult result) async {
    assert(result.errorCode == 0);
    if (result.errorCode != 0) {
      ZegoLoggerService.logInfo(
        'failed to login room:${result.errorCode},${result.extendedData}',
        tag: 'audio room',
        subTag: 'prebuilt',
      );
    }
  }

  Future<void> uninitContext() async {
    await ZegoUIKit().resetSoundEffect();
    await ZegoUIKit().resetBeautyEffect();

    await ZegoUIKit().leaveRoom();

     await ZegoUIKit().uninit();
  }

  void initToast() {
    ZegoToast.instance.init(contextQuery: () {
      return context;
    });
  }

  Future<bool> onLeaveConfirmation(BuildContext context) async {
    if (widget.config.confirmDialogInfo == null ||
        seatManager?.localRole.value != ZegoLiveAudioRoomRole.host) {
      return true;
    }

    return showLiveDialog(
      context: context,
      title: widget.config.confirmDialogInfo!.title,
      content: widget.config.confirmDialogInfo!.message,
      leftButtonText: widget.config.confirmDialogInfo!.cancelButtonName,
      leftButtonCallback: () {
        //  pop this dialog
        Navigator.of(context).pop(false);
      },
      rightButtonText: widget.config.confirmDialogInfo!.confirmButtonName,
      rightButtonCallback: () {
        //  pop this dialog
        Navigator.of(context).pop(true);
      },
    );
  }

  void onUserJoined(List<ZegoUIKitUser> users) {
    onInRoomUserAttributesUpdated();

    for (final user in users) {
      ZegoUIKit()
          .getInRoomUserAttributesNotifier(user.id)
          .addListener(onInRoomUserAttributesUpdated);
    }
  }

  void onUserLeave(List<ZegoUIKitUser> users) {
    for (final user in users) {
      ZegoUIKit()
          .getInRoomUserAttributesNotifier(user.id)
          .removeListener(onInRoomUserAttributesUpdated);
    }

    onInRoomUserAttributesUpdated();
  }

  void onInRoomUserAttributesUpdated() {
    widget.config.onUserCountOrPropertyChanged?.call(ZegoUIKit().getAllUsers());
  }
}
