import 'package:equatable/equatable.dart';

class OfficialSystemModel extends Equatable {
 final List <OfficialMsgModel>? sys ; 
  final List <OfficialMsgModel>? official ; 

OfficialSystemModel({required this.sys , required this.official});

factory OfficialSystemModel.fromJson(Map<String, dynamic> jsonData) =>
OfficialSystemModel(       official:jsonData['official'] == null ?  null:  List<OfficialMsgModel>.from((jsonData['official'] as List).map((e) => OfficialMsgModel.fromJson(e),)),
sys: jsonData['sys'] == null ?  null:  List<OfficialMsgModel>.from((jsonData['sys'] as List).map((e) => OfficialMsgModel.fromJson(e),))

 );
  @override
  // TODO: implement props
  List<Object?> get props =>[sys ,official ];


}

class OfficialMsgModel extends Equatable {
  final String title;
  final String img;
  final String content;
  final String url;
  final String created;
  final String updated;
  final int fromUserId;
  final int id;
  final int userId;
  final int type;
  // final int isRead;

  OfficialMsgModel(
      {required this.title,
      required this.img,
      required this.content,
      required this.url,
      required this.created,
      required this.updated,
      required this.id,
      required this.userId,
      required this.type,
      required this.fromUserId,
      // required this.isRead
      
      });

  factory OfficialMsgModel.fromJson(Map<String, dynamic> jsonData) =>
      OfficialMsgModel(
          title: jsonData['title']??"",
          type: jsonData['type']??0,
          content: jsonData['content']??"",
          created: jsonData['created_at']??"",
          updated: jsonData['updated_at']??"",
          // isRead: jsonData['is_read'],
          url: jsonData['url']??"",
          userId: jsonData['user_id']??0,
          id: jsonData['id'],
          img: jsonData['img']??"",
        fromUserId: jsonData['from_user_id']??0,
      );
  @override
  List<Object?> get props => [];
}
