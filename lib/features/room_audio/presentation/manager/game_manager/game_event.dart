import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/cancel_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_game_choise_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/start_game_uc.dart';

abstract class GameEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class InviteToGame extends GameEvent{

  final InviteToGamePramiter inviteToGamePramiter;

  InviteToGame({required this.inviteToGamePramiter});
}

class CancelGame extends GameEvent{

  final CancelGamePramiter cancelGamePramiter;

  CancelGame({required this.cancelGamePramiter});
}

class StartGame extends GameEvent{

  final StartGamePramiter startGamePramiter;

  StartGame({required this.startGamePramiter});
}

class SendGameChoise extends GameEvent{

  final SendGameChoisePramiter sendGameChoisePramiter;

  SendGameChoise({required this.sendGameChoisePramiter});
}