


import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';

class DataMallModel extends DataMallEntities {
  const DataMallModel(
      {required super.svg,
      required super.name,
      required super.title,
      required super.price,
      required super.color,
      required super.expire,
      required super.image,
      required super.id});

  factory DataMallModel.fromJson(Map<String, dynamic> json) {
    var jsonData = json;
    return DataMallModel(
        id: jsonData["id"],
        name: jsonData[ConstentApi.name],
        title: jsonData[ConstentApi.title],
        price: jsonData[ConstentApi.price],
        color: jsonData[ConstentApi.color] ?? "",
        expire: jsonData[ConstentApi.expire],
        image: jsonData[ConstentApi.image],
        svg: jsonData["svg"] ?? "");
  }
}
