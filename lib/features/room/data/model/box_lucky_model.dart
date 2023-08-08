
import 'package:equatable/equatable.dart';

class BoxLuckyModel extends Equatable {

  final  List<TypeBox> normalBox ;
  final List<TypeBox> superBox ;

  const BoxLuckyModel({required this.normalBox,required this.superBox});
  
  factory BoxLuckyModel.fromJson(Map<String,dynamic> json){
    return BoxLuckyModel(
        normalBox: List<TypeBox>.from(json['normal'].map((e)=>TypeBox.fromJson(e))),
        superBox:  List<TypeBox>.from(json['super'].map((e)=>TypeBox.fromJson(e)))) ;
  }

  @override
  List<Object?> get props => [normalBox,superBox];
}


class TypeBox extends Equatable {
  final int? id ;
  final String? type ;
  final  int?  coins ;
  final int?  userNum;
  final bool? isLabel ;


  const TypeBox({required  this.id, required this.type, required this.coins,required this.userNum,
    required  this.isLabel});

  factory TypeBox.fromJson(Map<String,dynamic> json)=>
      TypeBox(id: json['id'], type: json['type'], coins: json['coins']??0,
          userNum: json['users_num']??0, isLabel: json['is_label']) ;
  
  @override
  List<Object?> get props => [id,type,coins,userNum,isLabel];
}