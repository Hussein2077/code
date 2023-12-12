import 'package:equatable/equatable.dart';

abstract class PayEvent extends Equatable {}

class PayNow extends PayEvent {
  final String message;
  final String type;
  PayNow ({required this.message, required this.type});

  @override
  List<Object?> get props => [message, type];


}