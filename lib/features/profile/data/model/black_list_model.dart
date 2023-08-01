


import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class BlackListModel {
  final List<OwnerDataModel> data;
  const BlackListModel({required this.data});
  factory BlackListModel.fromJson(Map<String, dynamic> json) {
    return BlackListModel(
      data: List<OwnerDataModel>.from(
          json['data'].map((x) => OwnerDataModel.fromMap(x))),
    );
  }
}
