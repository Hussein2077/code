// ignore_for_file: unnecessary_question_mark

import 'package:equatable/equatable.dart';


class UserTopModel extends Equatable {
  final int? exp;
  final int? userId;
  // final String? sex;

  final String? avater;
  final String? name;
  final String? frame;
  final dynamic? frameId;


  const UserTopModel(
      {this.exp,
      this.userId,
      // this.sex,
      this.avater,
      this.name,
      this.frame,
      this.frameId,
     
     });

  factory UserTopModel.fromJson(Map<String, dynamic> jsonData) {
    return UserTopModel(
      exp: jsonData['exp']??0,
      userId: jsonData['user_id'],
      // sex: jsonData['sex'] ?? "",
      avater: jsonData['avatar'] ?? "",
      name: jsonData['name'] ?? "",
      frame: jsonData['frame'] ?? "",
      frameId: jsonData['frame_id'] ??1
   
    );
  }

  @override
  List<Object?> get props =>
      [exp, userId,  avater, name, frame, frameId, ];
}
