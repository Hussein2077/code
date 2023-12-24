class ExtraRoomDataModel {
  ExtraRoomDataModel({
      this.success, 
      this.message, 
      this.data, 
      this.paginates,});

  ExtraRoomDataModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    paginates = json['paginates'];
  }
  bool? success;
  String? message;
  Data? data;
  dynamic paginates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['paginates'] = paginates;
    return map;
  }

}

class Data {
  Data({
      this.achievements,});

  Data.fromJson(dynamic json) {
    if (json['achievements'] != null) {
      achievements = [];
      json['achievements'].forEach((v) {
        achievements?.add(Achievements.fromJson(v));
      });
    }
  }
  List<Achievements>? achievements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (achievements != null) {
      map['achievements'] = achievements?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Achievements {
  Achievements({
      this.image,});

  Achievements.fromJson(dynamic json) {
    image = json['image'];
  }
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    return map;
  }

}