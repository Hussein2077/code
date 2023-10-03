import 'package:equatable/equatable.dart';

abstract class LuckyBoxesEvents  extends Equatable{
  @override
  List<Object?> get props => [];

}

class GetBoxesEvent extends LuckyBoxesEvents{


}

class SendBoxesEvent extends LuckyBoxesEvents{
  final String boxId ;
  final String ownerId ;
  final String  quintity ;

  SendBoxesEvent({required this.boxId, required  this.ownerId, required this.quintity});
}
class PickupBoxesEvent extends LuckyBoxesEvents{
  final String boxId ;


  PickupBoxesEvent({required this.boxId});
}