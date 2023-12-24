
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class ExtraRoomDataEvent extends Equatable {
  String OwnerId;
  ExtraRoomDataEvent(this.OwnerId);

  @override
  List<Object> get props => [];
}

class GetExtraRoomDataEvent extends ExtraRoomDataEvent {
  String OwnerId;
  GetExtraRoomDataEvent(this.OwnerId) : super(OwnerId);
}

