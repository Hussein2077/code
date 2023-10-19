

import 'package:equatable/equatable.dart';

class CarouselsModel extends Equatable {
  final int id;
  final String img;
  final int ownerId;
  final bool hasPassword;

  const CarouselsModel({
    required this.id,
    required this.img,
    required this.ownerId,
    required this.hasPassword,
  });

  factory CarouselsModel.fromJson(Map<String, dynamic> jsonData) {
    return CarouselsModel(
      id: jsonData['id'],
      img: jsonData['img'],
      ownerId: jsonData['owner_id'],
      hasPassword: jsonData['isLocked'],
    );
  }

  @override
  List<Object?> get props => [id, img, ownerId,hasPassword];
}