


// ignore_for_file: unnecessary_question_mark

import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class ShowFamilyModel {
  final int? id;
  final String? name;
  final String? introduce;
  final String? img;
  final bool? amImember;
  final int? maxNumOfMembers;
  final int? rank;
  final bool? amIOwner;
  final bool? amIAdmin;
  final List<OwnerDataModel>? members;
  final List<OwnerDataModel>?  admins ;
  final OwnerDataModel? myData ;
  final OwnerDataModel? ownerData;
  final int? numOfRequests;
  final FamilyLevel? familylevel;

  ShowFamilyModel(
      {required this.id,
      required this.img,
      required this.introduce,
      required this.maxNumOfMembers,
      required this.name,
      required this.rank,
      required this.amIAdmin,
      required this.amIOwner,
      required this.members,
      required this.amImember,
        required this.admins ,
      required this.numOfRequests , this.familylevel , required this.myData , required this.ownerData});
  factory ShowFamilyModel.fromJson(Map<String, dynamic> json) {
    return ShowFamilyModel(
      id: json['id'],
      img: json["image"],
      admins:List<OwnerDataModel>.from(
           json['admins'].map((x) => OwnerDataModel.fromMap(x)))
     ,
      introduce: json["introduce"],
      maxNumOfMembers: json["max_num_of_members"],
      name: json["name"],
      rank: json["rank"],
      amIAdmin: json['am_i_admin'],
      amIOwner: json['am_i_owner'],
      amImember: json['am_i_member'],
      numOfRequests: json['num_of_requests'],
      myData:json['me']== null ? null : OwnerDataModel.fromMap(json['me']),
      ownerData:json['owner']== null ? null :  OwnerDataModel.fromMap(json['owner']) ,
      members:  json['members']== null ? null :   List<OwnerDataModel>.from(
          json['members'].map((x) => OwnerDataModel.fromMap(x))),
      familylevel:  json['level']== null ? null : FamilyLevel.fromjson(json['level']),
    );
  }
}

class FamilyLevel {
 final int? levelExp;
 final String? levelName ; 
 final String? levelImag ;
 final dynamic? familyExp;
 final int? overCureentLevelExp;
 final int? nextExp;
 final String? nextName;
 final String? nextImage;
 final dynamic? per ;
 final int? rem ;
const FamilyLevel ({this.levelExp , this.levelName , this.levelImag , this.familyExp , this.overCureentLevelExp , this.nextExp , this.nextImage , this.nextName , this.per , this.rem});

factory FamilyLevel.fromjson(Map <String, dynamic> json){
  return FamilyLevel(levelExp: json['level_exp'] ,  levelName: json['level_name'] , levelImag: json['level_img'] , familyExp: json['family_exp'] , overCureentLevelExp: json['over_current_level_exp'] , nextExp: json['next_exp'], nextImage: json['next_img'],  nextName: json['next_name'], per: json['per'] , rem: json['rem']);
}

}
