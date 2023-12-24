import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/kick_out_user_widget.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.toMap()}");
}