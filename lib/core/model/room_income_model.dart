// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RoomIncomeModel {
  final String? roomCoins;
  final String? daySum;
  final String? weekSum;
  final String? monSum;
  final String? lastMonSum;
  RoomIncomeModel({
    this.roomCoins,
    this.daySum,
    this.weekSum,
    this.monSum,
    this.lastMonSum,
  });

  RoomIncomeModel copyWith({
    String? roomCoins,
    String? daySum,
    String? weekSum,
    String? monSum,
    String? lastMonSum,
  }) {
    return RoomIncomeModel(
      roomCoins: roomCoins ?? this.roomCoins,
      daySum: daySum ?? this.daySum,
      weekSum: weekSum ?? this.weekSum,
      monSum: monSum ?? this.monSum,
      lastMonSum: lastMonSum ?? this.lastMonSum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'room_coins': roomCoins,
      'day_sum': daySum,
      'week_sum': weekSum,
      'mon_sum': monSum,
      'last_mon_sum': lastMonSum,
    };
  }

  factory RoomIncomeModel.fromMap(Map<String, dynamic> map) {
    return RoomIncomeModel(
      roomCoins: map['room_coins'] != null ? map['room_coins'] as String : null,
      daySum: map['day_sum'] != null ? map['day_sum'] as String : null,
      weekSum: map['week_sum'] != null ? map['week_sum'] as String : null,
      monSum: map['mon_sum'] != null ? map['mon_sum'] as String : null,
      lastMonSum: map['last_mon_sum'] != null ? map['last_mon_sum'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomIncomeModel.fromJson(String source) => RoomIncomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomIncomeModel(room_coins: $roomCoins, day_sum: $daySum, week_sum: $weekSum, mon_sum: $monSum, last_mon_sum: $lastMonSum)';
  }

  @override
  bool operator ==(covariant RoomIncomeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.roomCoins == roomCoins &&
      other.daySum == daySum &&
      other.weekSum == weekSum &&
      other.monSum == monSum &&
      other.lastMonSum == lastMonSum;
  }

  @override
  int get hashCode {
    return roomCoins.hashCode ^
      daySum.hashCode ^
      weekSum.hashCode ^
      monSum.hashCode ^
      lastMonSum.hashCode;
  }
}
