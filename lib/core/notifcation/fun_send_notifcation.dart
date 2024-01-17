import 'package:dio/dio.dart';

import 'package:tik_chat_v2/core/notifcation/model.dart';

class SendNotifcation {
  static void sendNotification(
      {required String title,
      required String body,
      required String token}) async {
    SendNotification notification =
        SendNotification(tokenNotification: token, body: body, title: title);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAYyrfZ8U:APA91bHcAaUhToEPWGpd_DfsUVv6aZLKttTDem_WF0rXJbHZMVERG9MP11G_TzcJKW_xnvzZx2R0t4Y-kCvCZn7UqfX8f6mJmVzTNAJ10lsMLMpje9AXdrCeSQ8l98H_sozao1vw9UeW',
    };

    await Dio().post('https://fcm.googleapis.com/fcm/send',
        data: notification.toJson(), options: Options(headers: headers));
  }
}
