
class ImageIdModel {

  int id;

  String image;

  String color;

  ImageIdModel({required this.id,required this.image,required this.color});

  factory ImageIdModel.fromMap(Map<String, dynamic> map) {

    return ImageIdModel(
      id: map['id']??0,
      image: map['image']??'',
      color :map['color']??"#000000",

    );
  }
}