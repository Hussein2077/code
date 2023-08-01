import 'package:equatable/equatable.dart';

class BackPackEnities extends Equatable {
  final int id;
  final String name;
  final String type;
  final String showImg;
  final String expire;
  final int targetId;
  final int firstUsed ; 
    final int isDress ; 


  const BackPackEnities(
      { required this.firstUsed,
        required this.expire,
      required this.id,
      required this.showImg,
      required this.type,
      required this.targetId,
      required this.isDress,
      required this.name
      
      });

  @override
  List<Object?> get props => [id, type, showImg , name];
}
