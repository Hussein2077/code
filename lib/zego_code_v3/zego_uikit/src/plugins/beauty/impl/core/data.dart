// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:

/// @nodoc
class ZegoBeautyPluginCoreData {
  bool inited = false;

  /// create engine
  Future<void> create({required int appID, String appSign = ''}) async {
    if (ZegoPluginAdapter().getPlugin(ZegoUIKitPluginType.beauty) == null)
      return;
    if (inited) {
      ZegoLoggerService.logInfo(
        'has created.',
        tag: 'uikit',
        subTag: 'beauty core data',
      );

      return;
    }

    ZegoPluginAdapter().beautyPlugin!.init(appID: appID, appSign: appSign);
    inited = true;

    ZegoLoggerService.logInfo(
      'create, appID:$appID',
      tag: 'uikit',
      subTag: 'beauty core data',
    );
  }

  /// destroy engine
  Future<void> destroy() async {
    if (ZegoPluginAdapter().getPlugin(ZegoUIKitPluginType.beauty) == null)
      return;

    ZegoPluginAdapter().beautyPlugin!.uninit();
    inited = false;
    ZegoLoggerService.logInfo(
      'destroy.',
      tag: 'uikit',
      subTag: 'beauty core data',
    );
    clear();
  }

  void clear() {
    ZegoLoggerService.logInfo(
      'clear',
      tag: 'uikit',
      subTag: 'beauty core data',
    );
  }

  /// setConfig
  void setConfig(ZegoBeautyPluginConfig config) {
    if (ZegoPluginAdapter().getPlugin(ZegoUIKitPluginType.beauty) != null) {
      ZegoPluginAdapter().beautyPlugin!.setConfig(config);
    }
  }

  /// showBeautyUI
  void showBeautyUI(BuildContext context) {
    if (ZegoPluginAdapter().getPlugin(ZegoUIKitPluginType.beauty) != null) {
      ZegoPluginAdapter().beautyPlugin!.showBeautyUI(context);
    }
  }
}
