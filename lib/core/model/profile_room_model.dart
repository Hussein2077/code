
// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

class ProfileRoomModel {
  final String? image;
  final int ? gender;
  final String? imageId;
  final dynamic? birthday;
  final dynamic? province;
  final dynamic? city;
  final dynamic? country;
  final int? age;

  ProfileRoomModel({
    this.image,
    this.gender,
    this.imageId,
    this.birthday,
    this.province,
    this.city,
    this.country,
    this.age,
  });

  ProfileRoomModel copyWith({
    dynamic? image,
    int ? gender,
    String? imageId,
    dynamic? birthday,
    dynamic? province,
    dynamic? city,
    dynamic? country,
  }) {
    return ProfileRoomModel(
      image: image ?? this.image,
      gender: gender ?? this.gender,
      imageId: imageId ?? this.imageId,
      birthday: birthday ?? this.birthday,
      province: province ?? this.province,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'gender': gender,
      'birthday': birthday,
      'province': province,
      'city': city,
      'country': country,
    };
  }

  factory ProfileRoomModel.fromMap(Map<String, dynamic> map) {
    return ProfileRoomModel(
      image: map['image'],
      imageId: map['image_id'],
      gender: 0,
      birthday: map['birthday'],
      province: map['province']??"",
      city: map['city'],
      country: map['country'],
      age: map['age'],
    );
  }


  factory ProfileRoomModel.fromJson(String source) =>
      ProfileRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);


}
