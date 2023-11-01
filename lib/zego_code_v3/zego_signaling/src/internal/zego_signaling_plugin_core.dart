// Package imports:
import 'package:zego_zim/zego_zim.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_signaling/src/internal/zego_signaling_plugin_event_center.dart';

/// @nodoc
class ZegoSignalingPluginCore {
  factory ZegoSignalingPluginCore() => _instance;

  ZegoSignalingPluginCore._() {
    eventCenter.init();
  }

  bool get isLogin => currentUser != null;

  ZIMUserInfo? currentUser;
  final eventCenter = ZegoSignalingPluginEventCenter();

  static final _instance = ZegoSignalingPluginCore._();
}
