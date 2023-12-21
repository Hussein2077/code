// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ExtraRoomDataModel.dart';

abstract class ExtraRoomDataState extends Equatable {
  const ExtraRoomDataState();

  @override
  List<Object> get props => [];
}

class ExtraRoomDataInitial extends ExtraRoomDataState {}

class ExtraRoomDataloadingState extends ExtraRoomDataState {}

class ExtraRoomDataFilureState extends ExtraRoomDataState {
  String error;
  ExtraRoomDataFilureState({required this.error});
}

class ExtraRoomDataSuccessState extends ExtraRoomDataState {
  ExtraRoomDataModel data;
  ExtraRoomDataSuccessState({required this.data});
}