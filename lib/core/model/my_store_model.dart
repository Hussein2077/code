// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MyStoreModel {
  final String? totalCoins;
  final int? coupons;
  final dynamic coins;
  final int? silverCoin;
  final dynamic diamonds;
  MyStoreModel(
      {this.totalCoins,
      this.coupons,
      this.coins,
      this.diamonds,
      this.silverCoin});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_coins': totalCoins,
      'coupons': coupons,
    };
  }

  factory MyStoreModel.fromMap(Map<String, dynamic> map) {
    return MyStoreModel(
        totalCoins: map['total_coins'] != null ? map['total_coins'] as String : null,
        coupons: map['coupons'] != null ? map['coupons'] as int : null,
        coins: map['coins'] != null ? map['coins'] as dynamic : 0,
        diamonds: map['diamonds'] != null ? map['diamonds'] as dynamic : 0,
        silverCoin: map['silver_coins'] != null ? map['silver_coins'] as int : 0);
  }

  String toJson() => json.encode(toMap());

  factory MyStoreModel.fromJson(String source) =>
      MyStoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MyStoreModel(total_coins: $totalCoins, coupons: $coupons)';

  @override
  bool operator ==(covariant MyStoreModel other) {
    if (identical(this, other)) return true;

    return other.totalCoins == totalCoins && other.coupons == coupons;
  }

  @override
  int get hashCode => totalCoins.hashCode ^ coupons.hashCode;
}
