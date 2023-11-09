import 'dart:developer';

import 'package:equatable/equatable.dart';

class UserOnMicModel extends Equatable {

  final int id ;
  final String name;
  final String img ;

  const UserOnMicModel({required this.id,required  this.name, required this.img});


  factory UserOnMicModel.fromJson(Map<String,dynamic>json ){
    return    UserOnMicModel(
            id:json['id']??0,
            name: json['name']??'',img: json['img']

    );
}
  @override
  List<Object?> get props => [id,name,img];


}