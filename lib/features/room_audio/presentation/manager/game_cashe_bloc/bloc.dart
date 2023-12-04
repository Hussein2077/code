import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/cache_games_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_cashe_bloc/event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_cashe_bloc/state.dart';
class CacheGamesBloc extends Bloc<CacheGameEvent, CacheStates> {
  final CacheGamesUc cacheGamesUS;
  CacheGamesBloc({required this.cacheGamesUS}) : super(ExtraDataInitial()) {
    on<FetchExtraDataEvent>((event, emit) async {
      emit(ExtraDataLoading());
      final result = await cacheGamesUS.call(event.type);
      result.fold((l) => emit(ExtraDataSuccess(l)),
          (r) => emit(ExtraDataError(DioHelper().getTypeOfFailure(r))));
    });

  }

}
