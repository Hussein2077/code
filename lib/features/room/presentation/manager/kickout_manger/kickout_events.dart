
import 'package:equatable/equatable.dart';

abstract class KickoutEvents extends Equatable {

}

class kickoutUser extends KickoutEvents{
  final String ownerId ;
  final String userId ;
  final String minutes ;

  kickoutUser({required this.ownerId,required this.userId, required this.minutes});

  @override
  List<Object?> get props => [ownerId,userId,minutes];

}