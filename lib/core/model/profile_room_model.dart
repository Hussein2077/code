
// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

class ProfileRoomModel {
  final String? image;
  final int ? gender;
  final String? imageId;
  final dynamic? birthday;
  final dynamic? country;
  final int? age;

  ProfileRoomModel({
    this.image,
    this.gender,
    this.imageId,
    this.birthday,
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
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'gender': gender,
      'birthday': birthday,
      'country': country,
    };
  }

  factory ProfileRoomModel.fromMap(Map<String, dynamic> map) {
    return ProfileRoomModel(
      image: map['image'],
      imageId: map['image_id'],
      gender: map['gender'],
      birthday: map['birthday'],
      country: map['country'],
      age: map['age'],
    );
  }


  factory ProfileRoomModel.fromJson(String source) =>
      ProfileRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);


}
