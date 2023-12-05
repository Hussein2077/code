
import 'package:equatable/equatable.dart';

abstract class HostOnMicTimeState extends Equatable {
  const HostOnMicTimeState();
}

class HostOnMicTimeInitial extends HostOnMicTimeState {
  @override
  List<Object> get props => [];
}

class HostOnMicTimeSucssesState extends HostOnMicTimeState {
  final String messsage ;
  const HostOnMicTimeSucssesState({required this.messsage});

  @override
  List<Object> get props => [];
}


class HostOnMicTimeErrorState extends HostOnMicTimeState {
  final String messsage ;
  const HostOnMicTimeErrorState({required this.messsage});
  @override
  List<Object> get props => [];
}


class HostOnMicTimeLoading extends HostOnMicTimeState {
  @override
  List<Object> get props => [];
}



