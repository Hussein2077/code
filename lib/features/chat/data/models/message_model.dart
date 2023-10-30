
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class messageModel extends Equatable {

  final String? from_Uid ;
  final String? to_Uid ;
  final String? from_name ;
  final String? to_name ;
  final String? from_avatar ;
  final String? to_avatar;
  final String? last_msg ;
  final Timestamp? last_time ;
  final int? msg_num ;

  messageModel(
      {this.from_Uid,
      this.to_Uid,
      this.from_name,
      this.to_name,
      this.from_avatar,
      this.to_avatar,
      this.last_msg,
      this.last_time,
        this.msg_num,
      });

  factory messageModel.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot  ,SnapshotOptions?  options
      ){
    final data = snapshot.data() ;
    return messageModel(
      from_Uid: data?['from_uid'],
      to_Uid:  data?['to_uid'],
      from_name: data?['from_name'],
      to_name:  data?['to_name'],
      from_avatar: data?['from_avatar'],
      to_avatar: data?['to_avatar'],
      last_msg: data?['last_msg'],
      last_time: data?['last_time'],
      msg_num: data?['msg_num']
    );
  }
  Map<String,dynamic> toFirestore(){
    return {
      if(from_Uid != null) 'from_uid' :from_Uid ,
      if(to_Uid != null) 'to_uid' :to_Uid ,
      if(from_name != null) 'from_name' :from_name ,
      if(to_name != null) 'to_name' :to_name ,
      if(from_avatar != null) 'from_avatar' :from_avatar ,
      if(last_msg != null) 'last_msg' :last_msg ,
      if(last_time != null) 'last_time' :last_time ,
      if(msg_num != null) 'msg_num' :msg_num ,
      if(to_avatar != null) 'to_avatar' :to_avatar ,
    };
  }

  @override
  List<Object?> get props => [
   from_Uid ,
   to_Uid ,
   from_name ,
   to_name ,
   from_avatar ,
   to_avatar,
   last_msg ,
   last_time ,
   msg_num ,
  ];
}