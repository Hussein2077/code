


import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class FamilyMemberModel {
   List<UserDataModel> members;
  final List<UserDataModel> admin;
  UserDataModel owner;

  List<UserDataModel> get getMembers => members;
     set setMembers(List<UserDataModel> member) => members;


  FamilyMemberModel(
      {required this.admin, required this.members, required this.owner});
  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) {
    return FamilyMemberModel(
      admin: List<UserDataModel>.from(
          json['admins'].map((x) => UserDataModel.fromMap(x))),
      members: List<UserDataModel>.from(
          json['members'].map((x) => UserDataModel.fromMap(x))),
      owner: UserDataModel.fromMap(json['owner']),
    );
  }
}
 class  MemberFamilyDataModel extends Equatable {







  @override
  List<Object?> get props => throw UnimplementedError();

 }
