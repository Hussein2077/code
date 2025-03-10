// ignore_for_file: unnecessary_question_mark

import 'package:equatable/equatable.dart';


class UserTopModel extends Equatable {
  final dynamic? exp;
  final int? userId;
  // final String? sex;

  final String? avater;
  final String? name;
  final String? frame;
  final dynamic? frameId; 
  final String? senderImage;
  final String? receverImage;
  final int? vipLevel;


  const UserTopModel(
      {this.exp,
      this.userId,
      // this.sex,
      this.avater,
      this.name,
      this.frame,
      this.frameId,
     this.vipLevel,
        this.senderImage,
        this.receverImage,
     });

  factory UserTopModel.fromJson(Map<String, dynamic> jsonData) {
    return UserTopModel(
      exp: jsonData['exp'].toString()??'',
      userId: jsonData['user_id'],
      // sex: jsonData['sex'] ?? "",
      avater: (jsonData['avatar']==null ||jsonData['avatar']=="")? "tic_logo.jpg":jsonData['avatar'],
      name: jsonData['name'] ?? "",
      frame: jsonData['frame'] ?? "",
      frameId: jsonData['frame_id'] ??1,
        vipLevel:jsonData['vip_level']??0,
       senderImage:jsonData['sender_img']??'',
      receverImage:jsonData['resever_img']??'',
    );
  }

  @override
  List<Object?> get props =>
      [exp, userId,  avater, name, frame, frameId,vipLevel,senderImage ];
}
