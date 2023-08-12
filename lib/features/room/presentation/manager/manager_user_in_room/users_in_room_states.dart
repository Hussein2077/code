import 'package:equatable/equatable.dart';


abstract class OnUserInRoomStates extends Equatable {
  const OnUserInRoomStates();

  @override
  List<Object?> get props => [];
}

class  OnUserInRoomInitialState extends OnUserInRoomStates{
  const  OnUserInRoomInitialState ();
}

class MuteUserInRoomLoadingState extends OnUserInRoomStates{
  const  MuteUserInRoomLoadingState();
}

class  MuteUserInRoomErrorState extends OnUserInRoomStates {
  final String errorMessage;

  const  MuteUserInRoomErrorState({required this.errorMessage});
}

class MuteRoomSuccesState extends OnUserInRoomStates {
  final String succesMessage;

  const MuteRoomSuccesState({required this.succesMessage});
}
class UnMuteUserInRoomLoadingState extends OnUserInRoomStates{
  const  UnMuteUserInRoomLoadingState();
}

class  UnMuteUserInRoomErrorState extends OnUserInRoomStates {
  final String errorMessage;

  const  UnMuteUserInRoomErrorState({required this.errorMessage});
}

class UnMuteRoomSuccesState extends OnUserInRoomStates {
  final String succesMessage;

  const UnMuteRoomSuccesState({required this.succesMessage});
}

class InviteUserInRoomLoadingState extends OnUserInRoomStates{
  const  InviteUserInRoomLoadingState();
}

class  InviteUserInRoomErrorState extends OnUserInRoomStates {
  final String errorMessage;

  const  InviteUserInRoomErrorState({required this.errorMessage});
}

class InviteRoomSuccesState extends OnUserInRoomStates {
  final String succesMessage;

  const InviteRoomSuccesState({required this.succesMessage});
}