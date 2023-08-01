// ignore: file_names
import 'package:equatable/equatable.dart';


class UserPlatformModel extends Equatable {
  final String? email ;
  final String? name ;
  final PictureModel? pictureModel ;
  final String ? id ;
  

  const UserPlatformModel({this.name,this.pictureModel,this.email, this.id});



  factory UserPlatformModel.fromJson(Map<String,dynamic> json )=>
      UserPlatformModel(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        pictureModel: PictureModel.fromJson(  json['picture']['data'])
      );

  @override
  List<Object?> get props => [email,name,pictureModel,id];
}


class PictureModel extends Equatable {
  final String? url;
  final int? width;
  final int? height;

  const PictureModel({this.height ,this.width,this.url});

  @override
  List<Object?> get props => [url ,width ,height];

   factory PictureModel.fromJson(Map<String,dynamic> json) =>
       PictureModel(
         url: json["url"],
         width: json["width"],
         height: json["height"]
       );
}