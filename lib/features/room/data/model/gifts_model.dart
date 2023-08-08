

import 'package:equatable/equatable.dart';

class GiftsModel extends Equatable {
  final int id ;
  final String name;
  final String type;
  final String img;
  final String showImg;
  final String showImg2 ;
  final int price;
  final int vipLevel ;

  const GiftsModel(
      {required this.id,required  this.name,required  this.type, required  this.img,
       required   this.showImg, required this.price,required this.showImg2, required this.vipLevel});


factory GiftsModel.fromJson(Map<String,dynamic> jsonData){
  return GiftsModel(
    id: jsonData['id'],
    name:  jsonData['name']??"noName",
    type:  jsonData['type'],
      vipLevel:jsonData['vip_level'] ,
    price:  jsonData['price'],
    img:  jsonData['img'],
    showImg:  jsonData['show_img'],
    showImg2:  jsonData['show_img2']
  );
}

  @override
  List<Object?> get props => [
   id ,
   name,
   type,
   img,
   showImg,
   showImg2 ,
   price,
    vipLevel
  ];



}