

import 'package:equatable/equatable.dart';

class CarouselsModel extends Equatable {
  final int id;

  final String img;
  final String url;


  final int ownerId;
  final bool hasPassword;

  const CarouselsModel( {
    required this.id,
    required this.img,
    required this.url,
    //required this.contents,
    required this.ownerId,
    required this.hasPassword,
  });

  factory CarouselsModel.fromJson(Map<String, dynamic> jsonData) {
    return CarouselsModel(
      id: jsonData['id'],
      url: jsonData['url']??"",
      img: jsonData['img'],
      ownerId: jsonData['owner_id']??0,
      hasPassword: jsonData['isLocked']??false,
    );
  }

  @override
  List<Object?> get props => [id, img, ownerId,hasPassword,url];
}