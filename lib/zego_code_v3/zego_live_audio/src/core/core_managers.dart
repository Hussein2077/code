// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';

// Package imports:

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/pop_up_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/live_duration_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/plugins.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/seat/seat_manager.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/minimizing/prebuilt_data.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/zego_uikit_signaling_plugin.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

class ZegoLiveAudioRoomManagers {
  factory ZegoLiveAudioRoomManagers() => _instance;

  ZegoLiveAudioRoomManagers._internal();

  static final ZegoLiveAudioRoomManagers _instance =
      ZegoLiveAudioRoomManagers._internal();

  void updateContextQuery(BuildContext Function() contextQuery) {
    ZegoLoggerService.logInfo(
      'update context query',
      tag: 'audio room',
      subTag: 'core manager',
    );

    ZegoLiveConnectManager.contextQuery  = contextQuery;
    ZegoLiveSeatManager.contextQuery = contextQuery;
  }

  void initPluginAndManagers({
    required ZegoUIKitPrebuiltLiveAudioRoomData prebuiltData,
  }) {
    if (_initialized) {
      ZegoLoggerService.logInfo(
        'had init',
        tag: 'audio room',
        subTag: 'core manager',
      );

      return;
    }

    ZegoLoggerService.logInfo(
      'init plugin and managers',
      tag: 'audio room',
      subTag: 'core manager',
    );

    _initialized = true;

    plugins = ZegoPrebuiltPlugins(
      appID: prebuiltData.appID,
      appSign: prebuiltData.appSign,
      userID: prebuiltData.userID,
      userName: prebuiltData.userName,
      roomID: prebuiltData.roomID,
      plugins: [ZegoUIKitSignalingPlugin()],
      onPluginReLogin: () {
        seatManager?.queryRoomAllAttributes(withToast: false).then((value) {
          seatManager?.initRoleAndSeat();
        });
      },
    );
    seatManager = ZegoLiveSeatManager(
      localUserID: prebuiltData.userID,
      roomID: prebuiltData.roomID,
      plugins: plugins!,
      config: prebuiltData.config,
      prebuiltController: prebuiltData.controller,
      innerText: prebuiltData.config.innerText,
      popUpManager: popUpManager,
      kickOutNotifier: kickOutNotifier,
      isHost: prebuiltData.roomData.ownerId == MyDataModel.getInstance().id,
      ownerId:prebuiltData.roomData.ownerId.toString() ,
    );
    connectManager = ZegoLiveConnectManager(
      config: prebuiltData.config,
      seatManager: seatManager!,
      prebuiltController: prebuiltData.controller,
      innerText: prebuiltData.config.innerText,
      popUpManager: popUpManager,
      kickOutNotifier: kickOutNotifier,
      roomData: prebuiltData.roomData,
    );
    seatManager?.setConnectManager(connectManager!);

    liveDurationManager = ZegoLiveDurationManager(
      seatManager: seatManager!,
    );
  }

  Future<void> unintPluginAndManagers() async {
    ZegoLoggerService.logInfo(
      'uninit plugin and managers',
      tag: 'audio room',
      subTag: 'core manager',
    );

    if (!_initialized) {
      ZegoLoggerService.logInfo(
        'had not init',
        tag: 'audio room',
        subTag: 'core manager',
      );

      return;
    }

    _initialized = false;

    connectManager?.uninit();
    await seatManager?.uninit();
    await liveDurationManager?.uninit();
    await plugins?.uninit();

    connectManager = null;
    seatManager = null;
    liveDurationManager = null;
    plugins = null;
  }

  bool _initialized = false;
  ZegoPrebuiltPlugins? plugins;
  ZegoLiveSeatManager? seatManager;
  ZegoLiveConnectManager? connectManager;
  ZegoLiveDurationManager? liveDurationManager;

  final popUpManager = ZegoPopUpManager();
  final kickOutNotifier = ValueNotifier<bool>(false);
}
