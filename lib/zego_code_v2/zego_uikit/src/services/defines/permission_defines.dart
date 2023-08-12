// Package imports:
import 'package:permission_handler/permission_handler.dart';


// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';

export 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  final status = await permission.request();
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
