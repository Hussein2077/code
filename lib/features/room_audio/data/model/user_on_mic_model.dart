
import 'package:equatable/equatable.dart';

class UserOnMicModel extends Equatable {

  final int id ;
  final String name;
  final String img ;
  final String seatCondition ;

  const UserOnMicModel({required this.id,required  this.name, required this.img, required this.seatCondition});


  factory UserOnMicModel.fromJson(Map<String,dynamic>json ){
    return UserOnMicModel(
        id:json['id']??0,
        name: json['name']??'',
        img: json['img'],
        seatCondition: json['seat_condition']??''
    );
}
  @override
  List<Object?> get props => [id,name,img,seatCondition];


}