import 'package:equatable/equatable.dart';

class UserBadgesModel extends Equatable{

  final List<ImageData> data;

  UserBadgesModel({
    required this.data,
  });

  factory UserBadgesModel.fromJson(Map<String, dynamic> json) {


    return UserBadgesModel(

      data:  List<ImageData>.from(
          json["data"].map((x) => ImageData.fromJson(x))),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class ImageData extends Equatable{
  final String image;

  ImageData({required this.image});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      image: json['image'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [image];
}
