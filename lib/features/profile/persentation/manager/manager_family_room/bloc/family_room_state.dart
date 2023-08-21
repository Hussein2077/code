
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';

abstract class FamilyRoomState extends Equatable {
  const FamilyRoomState();

  @override
  List<Object> get props => [];
}

class FamilyRoomInitial extends FamilyRoomState {}

class FamilyRoomLoadingState extends FamilyRoomState {}

class FamilyRoomSucssesState extends FamilyRoomState {
  final AllRoomsDataModel data;
  const FamilyRoomSucssesState({required this.data});
}

class FamilyRoomLErrorState extends FamilyRoomState {
  final String error;
  const FamilyRoomLErrorState({required this.error});
}
