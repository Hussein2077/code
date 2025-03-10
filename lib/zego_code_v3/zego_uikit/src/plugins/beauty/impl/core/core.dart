// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/beauty/impl/core/data.dart';

/// @nodoc
class ZegoBeautyPluginCore {
  ZegoBeautyPluginCore._internal();

  static ZegoBeautyPluginCore shared = ZegoBeautyPluginCore._internal();
  ZegoBeautyPluginCoreData coreData = ZegoBeautyPluginCoreData();

  /// get version
  Future<String> getVersion() async {
    return ZegoPluginAdapter().beautyPlugin?.getVersion() ??
        Future.value('beautyPlugin:null');
  }

  /// init
  Future<void> init({required int appID, String appSign = ''}) async {
    // initEvent();
    coreData.create(appID: appID, appSign: appSign);
  }

  /// uninit
  Future<void> uninit() async {
    // uninitEvent();
    return coreData.destroy();
  }

  /// setConfig
  void setConfig(ZegoBeautyPluginConfig config) {
    coreData.setConfig(config);
  }

  /// showBeautyUI
  void showBeautyUI(BuildContext context) {
    coreData.showBeautyUI(context);
  }
}
