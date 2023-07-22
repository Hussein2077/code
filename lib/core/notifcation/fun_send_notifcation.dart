
import 'package:dio/dio.dart';

import 'package:tik_chat_v2/core/notifcation/model.dart';

class SendNotifcation {
 static void sendNotification({required String title,required String body,required String token})async{

    SendNotification notification = SendNotification(
      tokenNotification: token,
      body : body,
      title: title
    );
      Map<String, String> headers = {
        'Content-Type':'application/json',
      'Authorization': 'key=AAAAPKaU5XM:APA91bHXWFmYLnGmAbvsBWeHzFuwF8Gj9AoyycLBbpti5NJhYLtkJR3YpKj-EfAlCaGTRF9s0Q2bfbY5jWRTOxX_qEJq47Q0lld6SPzZfzCGPk_PIJKs4nl-7OPYlRyaYI_0yB9TfSgg',
      };

    await Dio().post(

        'https://fcm.googleapis.com/fcm/send',
        data: notification.toJson(),
        options: Options(
          headers: headers
        )
      );
     
    


}
}