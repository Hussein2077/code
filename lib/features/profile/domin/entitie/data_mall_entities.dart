
import 'package:equatable/equatable.dart';

class DataMallEntities extends Equatable {
  final String name;
  final String title;
  final int price;
  final String color;
  final int expire;
  final String image;
  final String svg;
  final int id;

  const DataMallEntities(
      {required this.name,
      required this.title,
      required this.price,
      required this.color,
      required this.expire,
      required this.image,
      required this.svg,
      required this.id});

  @override
  List<Object?> get props =>
      [name, title, price, color, expire, image, svg, id];
}
