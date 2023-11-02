// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/beauty/impl/core/core.dart';

/// @nodoc
class ZegoUIKitBeautyPluginImpl {
  factory ZegoUIKitBeautyPluginImpl() => shared;
  ZegoUIKitBeautyPluginImpl._internal() {
    WidgetsFlutterBinding.ensureInitialized();
    assert(ZegoPluginAdapter().getPlugin(ZegoUIKitPluginType.beauty) != null,
        'ZegoUIKitBeautyPluginImpl: ZegoUIKitPluginType.beauty is null');
  }
  static final ZegoUIKitBeautyPluginImpl shared =
      ZegoUIKitBeautyPluginImpl._internal();

  /// init
  Future<void> init(
    int appID, {
    String appSign = '',
  }) async {
    return ZegoBeautyPluginCore.shared.init(appID: appID, appSign: appSign);
  }

  /// uninit
  Future<void> uninit() async {
    return ZegoBeautyPluginCore.shared.uninit();
  }

  void showBeautyUI(BuildContext context) {
    ZegoBeautyPluginCore.shared.showBeautyUI(context);
  }

  void setConfig(ZegoBeautyPluginConfig config) {
    ZegoBeautyPluginCore.shared.setConfig(config);
  }
}
