
import 'package:equatable/equatable.dart';

abstract class BaseHostOnMicTimeEvent extends Equatable {
  const BaseHostOnMicTimeEvent();
}


class HostOnMicTimeEvent extends BaseHostOnMicTimeEvent {
  final int totalTime ;
  const HostOnMicTimeEvent({required this.totalTime });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}