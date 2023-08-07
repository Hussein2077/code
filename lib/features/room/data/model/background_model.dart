import 'package:equatable/equatable.dart';

class BackGroundModel extends Equatable {
 final int id;
 final String img;
 const  BackGroundModel({required this.id, required this.img});


 factory BackGroundModel.fromjson(Map<String, dynamic> json) {
   return (BackGroundModel(id: json["id"] , img: json["img"]));
 }


  @override
  // TODO: implement props
  List<Object?> get props => [id , img];


}
