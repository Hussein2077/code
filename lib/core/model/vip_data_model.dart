// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

import 'package:flutter/foundation.dart';

class VipDataModel {
  final VipModel? data;
  final List<dynamic>? vipAuth;
  VipDataModel({
    this.data,
    this.vipAuth,
  });

  VipDataModel copyWith({
    VipModel? data,
    List<dynamic>? vipAuth,
  }) {
    return VipDataModel(
      data: data ?? this.data,
      vipAuth: vipAuth ?? this.vipAuth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'vip_auth': vipAuth,
    };
  }

  factory VipDataModel.fromMap(Map<String, dynamic> map) {

    return VipDataModel(
      data: map['my_data'] != null
          ? VipModel.fromMap(map['my_data'] as Map<String, dynamic>)
          : null,
      vipAuth: map['vip_auth'] != null
          ? List<dynamic>.from((map['vip_auth'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VipDataModel.fromJson(String source) =>
      VipDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VipDataModel(data: $data, vip_auth: $vipAuth)';

  @override
  bool operator ==(covariant VipDataModel other) {
    if (identical(this, other)) return true;

    return other.data == data && listEquals(other.vipAuth, vipAuth);
  }

  @override
  int get hashCode => data.hashCode ^ vipAuth.hashCode;
}

class VipModel {
  final int? vipNum;
  final int? vipLevel;
  final dynamic? nextVipNum;
  final dynamic? nextVipLevel;
  VipModel({
    this.vipNum,
    this.vipLevel,
    this.nextVipNum,
    this.nextVipLevel,
  });

  VipModel copyWith({
    int? vipNum,
    int? vipLevel,
    dynamic? nextVipNum,
    dynamic? nextVipLevel,
  }) {
    return VipModel(
      vipNum: vipNum ?? this.vipNum,
      vipLevel: vipLevel ?? this.vipLevel,
      nextVipNum: nextVipNum ?? this.nextVipNum,
      nextVipLevel: nextVipLevel ?? this.nextVipLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vip_num': vipNum,
      'vip_level': vipLevel,
      'next_vip_num': nextVipNum,
      'next_vip_level': nextVipLevel,
    };
  }

  factory VipModel.fromMap(Map<String, dynamic> map) {
    return VipModel(
      vipNum: map['vip_num'] != null ? map['vip_num'] as int : 0,
      vipLevel: map['vip_level'] != null ? map['vip_level'] as int : 0,
      nextVipNum:
          map['next_vip_num'] != null ? map['next_vip_num'] as dynamic : 0,
      nextVipLevel:
          map['next_vip_level'] != null ? map['next_vip_level'] as dynamic : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VipModel.fromJson(String source) =>
      VipModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VipModel(vip_num: $vipNum, vip_level: $vipLevel, next_vip_num: $nextVipNum, next_vip_level: $nextVipLevel)';
  }

  @override
  bool operator ==(covariant VipModel other) {
    if (identical(this, other)) return true;

    return other.vipNum == vipNum &&
        other.vipLevel == vipLevel &&
        other.nextVipNum == nextVipNum &&
        other.nextVipLevel == nextVipLevel;
  }

  @override
  int get hashCode {
    return vipNum.hashCode ^
        vipLevel.hashCode ^
        nextVipNum.hashCode ^
        nextVipLevel.hashCode;
  }
}
