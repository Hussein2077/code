


import 'package:tik_chat_v2/core/model/user_data_model.dart';

class BlackListModel {
  final List<UserDataModel> data;
  const BlackListModel({required this.data});
  factory BlackListModel.fromJson(Map<String, dynamic> json) {
    return BlackListModel(
      data: List<UserDataModel>.from(
          json['data'].map((x) => UserDataModel.fromMap(x))),
    );
  }
}
