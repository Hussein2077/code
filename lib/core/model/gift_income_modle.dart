// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GiftIncomeModle {
  final String? userCoins;
  final String? daySum;
  final String? weekSum;
  final String? monSum;
  final String? lastMonSum;
  GiftIncomeModle({
    this.userCoins,
    this.daySum,
    this.weekSum,
    this.monSum,
    this.lastMonSum,
  });

  GiftIncomeModle copyWith({
    String? userCoins,
    String? daySum,
    String? weekSum,
    String? monSum,
    String? lastMonSum,
  }) {
    return GiftIncomeModle(
      userCoins: userCoins ?? this.userCoins,
      daySum: daySum ?? this.daySum,
      weekSum: weekSum ?? this.weekSum,
      monSum: monSum ?? this.monSum,
      lastMonSum: lastMonSum ?? this.lastMonSum,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_coins': userCoins,
      'day_sum': daySum,
      'week_sum': weekSum,
      'mon_sum': monSum,
      'last_mon_sum': lastMonSum,
    };
  }

  factory GiftIncomeModle.fromMap(Map<String, dynamic> map) {
    return GiftIncomeModle(
      userCoins: map['user_coins'] != null ? map['user_coins'] as String : null,
      daySum: map['day_sum'] != null ? map['day_sum'] as String : null,
      weekSum: map['week_sum'] != null ? map['week_sum'] as String : null,
      monSum: map['mon_sum'] != null ? map['mon_sum'] as String : null,
      lastMonSum: map['last_mon_sum'] != null ? map['last_mon_sum'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftIncomeModle.fromJson(String source) => GiftIncomeModle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GiftIncomeModle(user_coins: $userCoins, day_sum: $daySum, week_sum: $weekSum, mon_sum: $monSum, last_mon_sum: $lastMonSum)';
  }

  @override
  bool operator ==(covariant GiftIncomeModle other) {
    if (identical(this, other)) return true;
  
    return 
      other.userCoins == userCoins &&
      other.daySum == daySum &&
      other.weekSum == weekSum &&
      other.monSum == monSum &&
      other.lastMonSum == lastMonSum;
  }

  @override
  int get hashCode {
    return userCoins.hashCode ^
      daySum.hashCode ^
      weekSum.hashCode ^
      monSum.hashCode ^
      lastMonSum.hashCode;
  }
}
