import 'show_family_model.dart';

class RoomFamilyModel {
  final int? id;
  final String? name;
  
  final FamilyLevel? familylevel;

  RoomFamilyModel(
      {required this.id,
  
      required this.name,
   this.familylevel ,});
  factory RoomFamilyModel.fromJson(Map<String, dynamic> json) {
    return RoomFamilyModel(
      id: json['family_id'],
  
      name: json["family_name"]==null? null :  json['family_name'],
    
      familylevel:  json['family_level']== null ? null : FamilyLevel.fromjson(json['family_level']),
    );
  }
}