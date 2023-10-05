class MomentLikeModel {
  
  int? userId ;
  String? uuId ;
  String? userName ;
  String?  userImage ; 
 MomentLikeModel ({this.userId , this.userImage , this.userName,this.uuId} );
   
factory MomentLikeModel.fromjson(Map <String , dynamic> json){
  return MomentLikeModel(
userId: json["user"]['id'],
    uuId: json["user"]['uuid'],
userImage: json["user"]['image'],
userName: json["user"]['name'],

  );
}

}