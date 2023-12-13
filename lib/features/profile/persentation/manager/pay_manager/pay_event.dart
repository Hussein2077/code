import 'package:equatable/equatable.dart';

abstract class PayEvent extends Equatable {}

class PayNow extends PayEvent {
  final String message;
  final String type;
  final String token;
  PayNow ({required this.message, required this.type, required this.token});

  @override
  List<Object?> get props => [message, type, token];


}