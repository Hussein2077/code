
import 'package:equatable/equatable.dart';

abstract class SendEvent extends Equatable {
  const SendEvent();

  @override
  List<Object> get props => [];
}

class sendItemEvent extends SendEvent {
  final String packId;
  final String touId;
  const sendItemEvent({required this.packId, required this.touId});
}


