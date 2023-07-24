
// ignore_for_file: unnecessary_question_mark

import 'dart:convert';

class ProfileRoomModel {
  final dynamic? image;
  final String? gender;
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
    String? gender,
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
      image: map['image'] != null ? map['image'] as dynamic : null,
      imageId: map['image_id'] != null ? map['image_id'] as dynamic : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as dynamic : null,
      province: map['province'] != null ? map['province'] as dynamic : null,
      city: map['city'] != null ? map['city'] as dynamic : null,
      country: map['country'] != null ? map['country'] as dynamic : null,
       age: map['age']  != null ? map['age'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileRoomModel.fromJson(String source) => ProfileRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileRoomModel(image: $image, gender: $gender, birthday: $birthday, province: $province, city: $city, country: $country)';
  }

  @override
  bool operator ==(covariant ProfileRoomModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.gender == gender &&
      other.birthday == birthday &&
      other.province == province &&
      other.city == city &&
      other.country == country;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      gender.hashCode ^
      birthday.hashCode ^
      province.hashCode ^
      city.hashCode ^
      country.hashCode;
  }
}
