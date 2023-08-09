import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SenderHistory extends Equatable {

  int ? id ;
  String ? uid;
  String ? name;
  String ? image;
  String ? type;
  


   SenderHistory({required this.id, required this.name, required this.image, required this.type , this.uid,});

  SenderHistory.fromJson(Map<String, dynamic> json) {
   id = json['id']??0;
   uid = json['uuid'].toString();
   name = json['name']??"";
   image = json['img']??"";
   type = json['type']??"";
 }

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    type,
  ];


}