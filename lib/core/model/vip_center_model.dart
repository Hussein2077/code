import 'package:equatable/equatable.dart';

class VipCenterModel extends Equatable {
  final int? id;
  final int? level;
  final String? name;
  final String? img1;
  final int? price;
  final int? expire;

  final List<Privilegs>? privilgesData;

  const VipCenterModel({
    this.expire,
    this.id,
    this.level,
    this.name,
    this.img1,
    this.price,
    this.privilgesData,
  });

  factory VipCenterModel.fromJson(Map<String, dynamic> jsonData) {
    return VipCenterModel(
      id: jsonData['id'],
      level: jsonData['level'] ?? 0,
      name: jsonData['name'] ?? "",
      img1: jsonData['img'] ?? "",
      price: jsonData['price'] ?? 0,
      expire: jsonData['expire'] ?? 0,
      privilgesData: jsonData['privilegs'] == null
          ? []
          : List<Privilegs>.from(
              jsonData['privilegs'].map((x) => Privilegs.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
        id,
        level,

        name,
        img1,
        price,
// privilgesData,
        expire,
      ];
}

class Item {
  final int? id;
  final String? name;
  final String? title;
  final String? image;

  const Item({this.id, this.name, this.title, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        title: json['title'] ?? "",
        image: json['image'] ?? "");
  }
}

class Privilegs extends Equatable {
  final int id;

  final String name;

  final String title;

  final String img1;

  final String img2;

  final bool active;


  const Privilegs({
    required this.img2,
    required this.id,
    required this.name,
    required this.title,
    required this.img1,
    required this.active,
  });

  factory Privilegs.fromJson(Map<String, dynamic> json) {
    return Privilegs(
        img2: json['img2'],
        id: json['id'],
        name: json['name'] ?? "",
        title: json['title'] ?? "",
        img1: json['img1'],
        active: json['active'] ?? false,

    );
  }

  @override
  List<Object?> get props => [id, name, title, img1, active];
}
