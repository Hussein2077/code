// Package imports:
import 'package:permission_handler/permission_handler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/logger_service.dart';

// Project imports:

/// @nodoc
Future<bool> requestPermission(Permission permission) async {
  PermissionStatus? status;
  try {
    status = await permission.request();
  } catch (e) {
    ZegoLoggerService.logInfo(
      'Exception: $permission permission not granted, $e',
      tag: 'uikit',
      subTag: 'permission',
    );
  }

  if (status != PermissionStatus.granted) {
    ZegoLoggerService.logInfo(
      'Error: $permission permission not granted, $status',
      tag: 'uikit',
      subTag: 'permission',
    );
    return false;
  }

  return true;
}
