import 'dart:developer';

import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';



class BackPackModel extends BackPackEnities {
  const BackPackModel(
      { required super.isDress, required super.firstUsed,
        required super.expire,
      required super.id,
      required super.showImg,
      required super.type,
      required super.targetId});
  factory BackPackModel.fromjson(Map<String, dynamic> json) {
    log(json['expire'].runtimeType.toString());
    return BackPackModel(
      isDress:json['is_dress'] ,
      firstUsed: json['is_used'],
        targetId: json['target_id'],
        expire: json['expire'].toString(),
        id: json['id'],
        showImg: json['show_img'],
        type: json['type']);
  }
}
