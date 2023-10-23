import 'dart:developer';

import 'package:equatable/equatable.dart';

class UserOnMicModel extends Equatable {

  final int id ;
  final String name;

  const UserOnMicModel({required this.id,required  this.name});


  factory UserOnMicModel.fromJson(Map<String,dynamic>json ){
    return    UserOnMicModel(
            id:json['id'],
            name: json['name']
        );
}
  @override
  List<Object?> get props => [id,name];


}