class MomentLikeModel {
  
  int? userId ;
  String? userName ; 
  String?  userImage ; 
 MomentLikeModel ({this.userId , this.userImage , this.userName} );
   
factory MomentLikeModel.fromjson(Map <String , dynamic> json){
  return MomentLikeModel(
userId: json["user"]['id'],
userImage: json["user"]['image'],
userName: json["user"]['name'],

  );
}

}