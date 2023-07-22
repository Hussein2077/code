// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';


import 'package:tik_chat_v2/core/model/gift_income_modle.dart';

import 'room_income_model.dart';

class IncomeDataModle {
  final int? isLeader;
  final GiftIncomeModle? giftIncome;
  final RoomIncomeModel? roomIncome;
  IncomeDataModle({
    this.isLeader,
    this.giftIncome,
    this.roomIncome,
  });
  IncomeDataModle copyWith({
    int? isLeader,
    GiftIncomeModle? giftIncome,
    RoomIncomeModel? roomIncome,
  }) {
    return IncomeDataModle(
      isLeader: isLeader ?? this.isLeader,
      giftIncome: giftIncome ?? this.giftIncome,
      roomIncome: roomIncome ?? this.roomIncome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_leader': isLeader,
      'gift_income': giftIncome?.toMap(),
      'room_income': roomIncome?.toMap(),
    };
  }

  factory IncomeDataModle.fromMap(Map<String, dynamic> map) {
    return IncomeDataModle(
      isLeader: map['is_leader'] != null ? map['is_leader'] as int : null,
      giftIncome: map['gift_income'] != null ? GiftIncomeModle.fromMap(map['gift_income'] as Map<String,dynamic>) : null,
      roomIncome: map['room_income'] != null ? RoomIncomeModel.fromMap(map['room_income'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeDataModle.fromJson(String source) => IncomeDataModle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IncomeDataModle(is_leader: $isLeader, gift_income: $giftIncome, room_income: $roomIncome)';

  @override
  bool operator ==(covariant IncomeDataModle other) {
    if (identical(this, other)) return true;
  
    return 
      other.isLeader == isLeader &&
      other.giftIncome == giftIncome &&
      other.roomIncome == roomIncome;
  }

  @override
  int get hashCode => isLeader.hashCode ^ giftIncome.hashCode ^ roomIncome.hashCode;
}
