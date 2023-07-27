


import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class FamilyRequestsModel {
  final List<FamilyRequest> data;
  FamilyRequestsModel({required this.data});
  factory FamilyRequestsModel.fromjson(Map<String, dynamic> json) {
    return FamilyRequestsModel(
      data: List<FamilyRequest>.from(
          json["data"].map((x) => FamilyRequest.fromJson(x))),
    );
  }
}

class FamilyRequest {
  final int id;
  final OwnerDataModel user;
  final String time;

  FamilyRequest(
      {required this.user,
      required this.id,
      required this.time});
  factory FamilyRequest.fromJson(Map<String, dynamic> json) {
    return FamilyRequest(
        user: OwnerDataModel.fromMap(json['user']),
        id: json['id'],
        time: json['time']);
  }
}
