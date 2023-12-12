
abstract class GameState {}

class GameInitial extends GameState {}


class InviteToGameLoadingState extends GameState {}

class InviteToGameErrorState extends GameState {
  final String error;
  InviteToGameErrorState({required this.error});
}

class InviteToGameSuccessState extends GameState {
  final String message;
  InviteToGameSuccessState({required this.message});
}

class CancelGameLoadingState extends GameState {}

class CancelGameErrorState extends GameState {
  final String error;
  CancelGameErrorState({required this.error});
}

class CancelGameSuccessState extends GameState {
  final String message;
  CancelGameSuccessState({required this.message});
}

class StartGameLoadingState extends GameState {}

class StartGameErrorState extends GameState {
  final String error;
  StartGameErrorState({required this.error});
}

class StartGameSuccessState extends GameState {
  final String message;
  StartGameSuccessState({required this.message});
}


class SendGameChoiseLoadingState extends GameState {}

class SendGameChoiseErrorState extends GameState {
  final String error;
  SendGameChoiseErrorState({required this.error});
}

class SendGameChoiseSuccessState extends GameState {
  final String message;
  SendGameChoiseSuccessState({required this.message});
}

class InviteToGameNewErrorState extends GameState {
  final String error;
  InviteToGameNewErrorState({required this.error});
}

class InviteToGameNewSuccessState extends GameState {
  final String message;
  InviteToGameNewSuccessState({required this.message});
}

class OtherPlayerActionErrorState extends GameState {
  final String error;
  OtherPlayerActionErrorState({required this.error});
}

class OtherPlayerActionSuccessState extends GameState {
  final String message;
  OtherPlayerActionSuccessState({required this.message});
}
