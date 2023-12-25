class SendPrivateCommentModel {
  SendPrivateCommentModel({
      this.success, 
      this.message, 
      this.paginates, 
      this.data,});

  SendPrivateCommentModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    paginates = json['paginates'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  dynamic paginates;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['paginates'] = paginates;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.message, 
      this.price, 
      this.fromUserId, 
      this.toUserId,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    price = json['price'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
  }
  String? message;
  int? price;
  int? fromUserId;
  String? toUserId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['price'] = price;
    map['from_user_id'] = fromUserId;
    map['to_user_id'] = toUserId;
    return map;
  }

}