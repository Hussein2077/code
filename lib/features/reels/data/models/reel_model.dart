


class ReelModel {
  int? id ; 
  int? userId ; 
  String? description ; 
  String? url  ;
  int? shareNum ; 
  int? commentNum ; 
  int? likeNum ; 
  bool? likeExists ; 
  String? userName ; 
  String? userImage ;
  bool? isFollow ;
  String? subVideo; 


  ReelModel ({this.subVideo, this.isFollow,this.userName , this.userImage ,  this.id , this.userId , this.description ,this.url ,this.shareNum , this.commentNum ,this.likeNum , this.likeExists});

  factory ReelModel.fromJson (Map <String, dynamic> json){
    return ReelModel(
      id: json['id']??0,
      userId: json['user_id']??0,
      description: json['description']??"",
      url: "https://storage.googleapis.com/tik-chat/${json['url']}",
      // shareNum: json['share_num']??0,
      commentNum: json['comments_count']??0,
      likeNum: json['likes_count']??0,
      likeExists: json['likes_exists']??false,
      userName: json["user"]==null? "" :json["user"]['name']??"",
      userImage: json["user"]==null?"": json["user"]['image']??"",
      isFollow: json["user"]==null?"": json["user"]['is_follow']??false,
      subVideo: json['sub_video']??""

    );
  }

}
