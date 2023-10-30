
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class messageContentModel extends Equatable {
  final String? uid ;
  final String? content ;
  final String? type ;
  final Timestamp? addTime ;

  messageContentModel({this.uid, this.content, this.type, this.addTime});

factory messageContentModel.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot ,
     SnapshotOptions? options
     ){
  final data = snapshot.data();
  return messageContentModel(
    uid:data?['uid'],
    content: data?['content'],
    type: data?['type'],
    addTime: data?['addtime']

  );
}

Map<String,dynamic> toFirestore(){
  return {
    if(uid !=null) 'uid':uid,
    if(content !=null) 'content':content,
    if(type !=null) 'type':type,
    if(addTime !=null) 'addtime':addTime,
  };
}

  @override
  List<Object?> get props => [
   uid ,
   content ,
   type ,
   addTime ,
  ];
}