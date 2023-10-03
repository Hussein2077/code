import 'package:equatable/equatable.dart';

abstract class TopInRoonEvents extends Equatable{

}


class getTopIn24HoursRoomEvent extends TopInRoonEvents {

  String typeDate ;
  String ownerId ;

  getTopIn24HoursRoomEvent({required this.typeDate, required this.ownerId});

  @override
  List<Object?> get props => [
    typeDate,
    ownerId
  ];


}
class getTopInTotalRoomEvent extends TopInRoonEvents {

  String typeDate ;
  String ownerId ;

  getTopInTotalRoomEvent({required this.typeDate, required this.ownerId});

  @override
  List<Object?> get props => [
    typeDate,
    ownerId
  ];


}