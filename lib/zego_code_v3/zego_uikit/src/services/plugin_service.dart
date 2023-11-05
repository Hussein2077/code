
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/plugins/beauty/uikit_beauty_plugin_impl.dart';
import '../../zego_uikit.dart';
/// @nodoc
// see IZegoUIKitPlugin
mixin ZegoPluginService {
  ValueNotifier<List<ZegoUIKitPluginType>> pluginsInstallNotifier() {
    return ZegoPluginAdapter().pluginsInstallNotifier;
  }

  /// install plugins
  void installPlugins(List<IZegoUIKitPlugin> plugins) {
    ZegoPluginAdapter().installPlugins(plugins);
  }

  /// uninstall plugins
  void uninstallPlugins(List<IZegoUIKitPlugin> plugins) {
    ZegoPluginAdapter().uninstallPlugins(plugins);
  }

  /// get plugin object
  IZegoUIKitPlugin? getPlugin(ZegoUIKitPluginType type) {
    return ZegoPluginAdapter().getPlugin(type);
  }

  /// signal plugin
  ZegoUIKitSignalingPluginImpl getSignalingPlugin() {
    return ZegoUIKitSignalingPluginImpl.shared;
  }

  ZegoUIKitBeautyPluginImpl getBeautyPlugin() {
    return ZegoUIKitBeautyPluginImpl.shared;
  }
}
