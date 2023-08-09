import 'package:tik_chat_v2/core/model/my_store_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';

class AgencyMemberModel {
  int? id ;
  String? uuid ;
  int? diamond ;
  String? name ; 
  String? image ;
  int? totalUsd ; 
AgencyMemberModel({this.diamond , this.id , this.image ,this.name , this.totalUsd , this.uuid});

factory AgencyMemberModel.fromJson(Map <String, dynamic> json){
  return AgencyMemberModel(diamond: json["diamonds"]??0,
  id: json['id']??0,
  image: json['profile']['image']??"tic_logo.jpg",
  name: json["name"]??"",
  totalUsd: json["total_used"]??0,
  uuid: json['uuid']??"",
  
  
  );
}


 convertToUserDataModel (){
  return UserDataModel(
    name: name , 
    id :id,
    uuid:  uuid ,
    myStore:MyStoreModel(diamonds: diamond)  ,
    profile: ProfileRoomModel(image: image),

    
  );
 }

}