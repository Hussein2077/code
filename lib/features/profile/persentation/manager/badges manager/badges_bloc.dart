import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_badges_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/badges%20manager/badges_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/badges%20manager/badges_state.dart';

class GetBadgesBloc extends Bloc<BadgesEvent,GetBadgesStates>{
  final GetBadgesUseCase getBadgesUseCase;
  GetBadgesBloc({required this.getBadgesUseCase}) : super(const GetBadgesStates()) {
    on<AchievementEvent>(getAchievement);
    on<HonorEvent>(getRooms);
    on<ActivityEvent>(getGifts);
  }
Future<void> getAchievement(AchievementEvent event, Emitter<GetBadgesStates> emit)async {
  final result = await getBadgesUseCase.getBadges(event.type);
  result.fold(
          (l) => emit(
          state.copyWith(achievementBadge: l, achievementBadgeRequest: RequestState.loaded)),
          (r) => emit(state.copyWith(
              achievementBadgeRequest: RequestState.error,
          activityBadgeMessage: DioHelper().getTypeOfFailure(r))));
}
  Future<void> getRooms(HonorEvent event, Emitter<GetBadgesStates> emit)async {
    final result = await getBadgesUseCase.getBadges(event.type);
    result.fold(
            (l) => emit(
            state.copyWith(honorBadge: l, honorBadgeRequest: RequestState.loaded)),
            (r) => emit(state.copyWith(
                honorBadgeRequest: RequestState.error,
            honorBadgeMessage: DioHelper().getTypeOfFailure(r))));
  }
  Future<void> getGifts(ActivityEvent event, Emitter<GetBadgesStates> emit)async {
    final result = await getBadgesUseCase.getBadges(event.type);
    result.fold(
            (l) => emit(
            state.copyWith(activityBadge: l, activityBadgeRequest: RequestState.loaded)),
            (r) => emit(state.copyWith(
            activityBadgeRequest: RequestState.error,
            activityBadgeMessage: DioHelper().getTypeOfFailure(r))));
  }


}