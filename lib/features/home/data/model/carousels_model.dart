
import 'package:equatable/equatable.dart';

class CarouselsModel extends Equatable {
  final int  id ;
  final String img ;
  final String contents ;
  final String url ;


  const CarouselsModel({
    required  this.id, required this.img, required this.contents,required this.url});



  factory CarouselsModel.fromJson(Map<String , dynamic > jsonData){
    return CarouselsModel(
        id: jsonData['id'],
        img:jsonData['img'],
        url:jsonData['url'],
        contents: jsonData['contents']
    );
  }
  @override
  List<Object?> get props => [id,img,contents];

}



