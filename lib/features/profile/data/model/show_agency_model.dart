import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class ShowAgencyModel {
  final int? id ; 
  final String? name ; 
  final String? notice ; 
  final String? image ; 
  final OwnerDataModel? owner ; 


  const ShowAgencyModel ({ this.id ,  this.image , this.name , this.notice , this.owner});

  factory ShowAgencyModel.fromJson(Map <String , dynamic> json){
    return ShowAgencyModel(id: json['id']??0,
    image: json['img']?? "tic_logo.jpg",
    name: json['name']?? "",
    notice: json['notice']?? "",
    owner: json["owner"]!=null? OwnerDataModel.fromMap(json["owner"]) : null
    
    );
  } 
}