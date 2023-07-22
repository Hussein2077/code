


import 'package:equatable/equatable.dart';

class AllMainClassesModel extends Equatable {
  final int? id;
  final String name;
  final String imag;
  const AllMainClassesModel({this.id, required this.name,required this.imag});


  factory AllMainClassesModel.fromjson(Map<String, dynamic> json) {
    return AllMainClassesModel(
        id: json['id']??0, name: json['name']??"any", imag: json['img']??"any");
  }
  @override
  List<Object?> get props => [id, name, imag];
}