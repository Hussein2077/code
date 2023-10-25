class InAppPurchaseMode {
  InAppPurchaseMode({
      this.success, 
      this.message, 
      this.data,});

  InAppPurchaseMode.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.coins,});

  Data.fromJson(dynamic json) {
    coins = json['coins'];
  }
  int? coins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coins'] = coins;
    return map;
  }

}