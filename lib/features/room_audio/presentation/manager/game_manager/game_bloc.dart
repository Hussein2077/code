
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/cancel_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_game_choise_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/start_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_states.dart';


class GameBloc extends Bloc<GameEvent, GameState> {
  InviteToGameUC inviteToGameUC;
  CancelGameUC cancelGameUC;
  StartGameUC startGameUC;
  SendGameChoiseUC sendGameChoiseUC;

  GameBloc({required this.inviteToGameUC, required this.cancelGameUC, required this.startGameUC, required this.sendGameChoiseUC}) : super(GameInitial()) {
    on<InviteToGame>(inviteToGame);
    on<CancelGame>(cancelGame);
    on<StartGame>(startGame);
    on<SendGameChoise>(sendGameChoise);
  }

  FutureOr<void> inviteToGame(InviteToGame event, emit) async {
    emit(InviteToGameLoadingState());
    final result = await inviteToGameUC.call(InviteToGamePramiter(
        ownerId: event.inviteToGamePramiter.ownerId,
        userId: event.inviteToGamePramiter.userId,
        coins: event.inviteToGamePramiter.coins,
        game_id: event.inviteToGamePramiter.game_id,
    ));
    result.fold((l) => emit(InviteToGameSuccessState(message: l)),
            (r) => emit(InviteToGameErrorState(error: DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> cancelGame(CancelGame event, emit) async {
    emit(CancelGameLoadingState());
    final result = await cancelGameUC.call(CancelGamePramiter(
        gameId: event.cancelGamePramiter.gameId
    ));
    result.fold((l) => emit(CancelGameSuccessState(message: l)),
            (r) => emit(CancelGameErrorState(error: DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> startGame(StartGame event, emit) async {
    emit(StartGameLoadingState());
    final result = await startGameUC.call(StartGamePramiter(
        gameId: event.startGamePramiter.gameId
    ));
    result.fold((l) => emit(StartGameSuccessState(message: l)),
            (r) => emit(StartGameErrorState(error: DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> sendGameChoise(SendGameChoise event, emit) async {
    emit(SendGameChoiseLoadingState());
    final result = await sendGameChoiseUC.call(SendGameChoisePramiter(
        gameId: event.sendGameChoisePramiter.gameId,
        answer: event.sendGameChoisePramiter.answer
    ));
    result.fold((l) => emit(SendGameChoiseSuccessState(message: l)),
            (r) => emit(SendGameChoiseErrorState(error: DioHelper().getTypeOfFailure(r))));

  }
}
