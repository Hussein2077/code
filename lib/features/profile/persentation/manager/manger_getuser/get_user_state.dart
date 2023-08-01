
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoddingState extends GetUserState {}

class GetUserErorrState extends GetUserState {
 final String error;
  const GetUserErorrState({required this.error});
}

class GetUserSucssesState extends GetUserState {
 final OwnerDataModel data;
  const GetUserSucssesState({required this.data});
}
