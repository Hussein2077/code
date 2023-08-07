import 'package:equatable/equatable.dart';

abstract class SendGiftEvents extends Equatable {



}

class SendGiftesEvent extends SendGiftEvents {
  final String ownerId;
  final  String id ;
  final String toUid ;
  final  String num ;
  final String toZego ;

  SendGiftesEvent({required this.ownerId, required this.id, required this.toZego, required this.toUid, required  this.num});

  @override
  List<Object?> get props => [ownerId,id,toUid,num, toZego];
}