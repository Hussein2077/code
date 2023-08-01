


// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

class LevelDataModel {
  final int? senderNum;
  final int? senderLevel;
  final int? nextSenderNum;
  final int? nextSenderLevel;
  final double? senderPer ;
  final dynamic? remSenderLevel ;
  final int? reciverNum;
  final int? reciverLivel;
  final dynamic? nextReciverNum;
  final dynamic? nextReciverLevel;
  final double? reciverPer ;
  final dynamic? remReceiverLevel ;
  final String? senderImage;
  final String? receiverImage;


  LevelDataModel({
    this.nextReciverLevel,
    this.nextReciverNum,
    this.nextSenderNum,
    this.nextSenderLevel,
    this.reciverLivel,
    this.reciverNum,
    this.senderLevel,
    this.senderNum,
    this.reciverPer,
    this.senderPer,
    this.remReceiverLevel,
    this.remSenderLevel,
    this.senderImage,
    this.receiverImage
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender_num': senderNum,
      'receiver_num': reciverNum,
      'sender_level': senderLevel,
      'next_sender_num': nextSenderNum,
      'next_sender_level': nextSenderLevel,
      'receiver_level': reciverLivel,
      'next_receiver_num': nextReciverNum,
      'next_receiver_level': nextReciverLevel,

    };
  }

  factory LevelDataModel.fromMap(Map<String, dynamic> map) {

    return LevelDataModel(
      remReceiverLevel: map['receiver_rem'],
      remSenderLevel: map['sender_rem'],
      reciverPer :map['receiver_per']==0 ? 0.0 :map['receiver_per'],
      senderPer :map['sender_per']==0 ? 0.0 :map['sender_per'],
      senderNum: map['sender_num'] != null ? map['sender_num'] as int : null,
      reciverNum: map['receiver_num'] != null ? map['receiver_num'] as int : null,
      senderLevel: map['sender_level'] != null ? map['sender_level'] as int : null,
      nextSenderNum: map['next_sender_num'] != null ? map['next_sender_num'] as int : null,
      nextSenderLevel: map['next_sender_level'] != null ? map['next_sender_level'] as int : null,
      reciverLivel: map['receiver_level'] != null ? map['receiver_level'] as int : null,
      nextReciverNum: map['next_receiver_num'] != null ? map['next_receiver_num'] as dynamic : null,
      nextReciverLevel: map['next_receiver_level'] != null ? map['next_receiver_level'] as dynamic : null,
      receiverImage: map['receiver_img']??'',
      senderImage: map['sender_img']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory LevelDataModel.fromJson(String source) => LevelDataModel.fromMap(json.decode(source) as Map<String, dynamic>);


}
