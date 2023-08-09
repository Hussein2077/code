



class FamilyMemberModel {
   List<MemberFamilyDataModel> members;
  final List<MemberFamilyDataModel> admin;
  MemberFamilyDataModel owner;

  List<MemberFamilyDataModel> get getMembers => members;
     set setMembers(List<MemberFamilyDataModel> member) => members;


  FamilyMemberModel(
      {required this.admin, required this.members, required this.owner});
  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      admin: List<MemberFamilyDataModel>.from(
          json['admins'].map((x) => MemberFamilyDataModel.fromJson(x))),
      members: List<MemberFamilyDataModel>.from(
          json['members'].map((x) => MemberFamilyDataModel.fromJson(x))),
      owner: MemberFamilyDataModel.fromJson(json['owner']),
    );
  }
}
 class  MemberFamilyDataModel  {

   int? id ;
  String? name ; 
  String? image ;
  int? age ; 
  String? gender ; 
  int? frameId ; 
  String? frame ; 
  bool ? isFamilyAdmin ; 
  int? familyId ; 

MemberFamilyDataModel({this.familyId ,  this.age , this.frame , this.frameId ,this.gender ,this.id , this.image , this.isFamilyAdmin , this.name});


factory MemberFamilyDataModel.fromJson(Map<String , dynamic> json){
  return MemberFamilyDataModel(
    id:json['id']??0,
    age: json['profile']['age']??0,
    gender:  json['profile']['gender']??"", 
    image:  json['profile']['image']??"tic_logo.jpg",
    frame: json['frame']??"",
    frameId: json['frame_id']??0,
    isFamilyAdmin: json['is_family_admin']??false,
    name: json['name']??"",
    familyId: json['family_id']??0

  );
}


 }
