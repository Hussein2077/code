class SendNotification {

  String tokenNotification;
  String title;
  String body;


  SendNotification({required this.tokenNotification, required this.title, required this.body});

  Map<String,dynamic>toJson(){

    return {

      "to": tokenNotification,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": {
        "url": "https://img.freepik.com/free-vector/chat-bubble_53876-25540.jpg?t=st=1647527122~exp=1647527722~hmac=280b047f3687829b790fd6244e1dbe34d19a6225df7687f82f70f0475b154ed0&w=740",
        "dl": "<deeplink action on tap of notification>"
      }

    };

  }

}