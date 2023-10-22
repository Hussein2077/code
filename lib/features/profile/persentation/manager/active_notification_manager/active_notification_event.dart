
import 'package:equatable/equatable.dart';

abstract class BaseActiveNotificationEvent extends Equatable {
  const BaseActiveNotificationEvent();

  @override
  List<Object> get props => [];
}

class ActiveNotificationEvent extends BaseActiveNotificationEvent{
  final bool state ;
  const ActiveNotificationEvent({required this.state});
}


