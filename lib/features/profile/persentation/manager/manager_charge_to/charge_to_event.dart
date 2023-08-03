
import 'package:equatable/equatable.dart';

abstract class ChargeToEvents extends Equatable{
  @override
  List<Object?> get props =>[];

}

class SendCharge extends ChargeToEvents{
  final String uId ;
  final String usd ;

  SendCharge({ required this.uId, required this.usd});
}
