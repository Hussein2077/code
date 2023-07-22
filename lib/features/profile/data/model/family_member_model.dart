


import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class FamilyMemberModel {
   List<OwnerDataModel> members;
  final List<OwnerDataModel> admin;
  OwnerDataModel owner;

  List<OwnerDataModel> get getMembers => members;
     set setMembers(List<OwnerDataModel> member) => members;


  FamilyMemberModel(
      {required this.admin, required this.members, required this.owner});
  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      admin: List<OwnerDataModel>.from(
          json['admins'].map((x) => OwnerDataModel.fromMap(x))),
      members: List<OwnerDataModel>.from(
          json['members'].map((x) => OwnerDataModel.fromMap(x))),
      owner: OwnerDataModel.fromMap(json['owner']),
    );
  }
}
