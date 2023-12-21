import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_badge_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/user_badges_manager/user_badges_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/user_badges_manager/user_badges_state.dart';

class UserBadgesBloc extends Bloc<UserBadgesEvent, UserBadgesState> {
  final GetUserBadgeUc getUserBadgeUc;
  UserBadgesBloc({required this.getUserBadgeUc}) : super(UserBadgesInitial()) {
    on<GetUserBadges>((event, emit) async{
      emit(UserBadgesLoadingState());
      final result = await getUserBadgeUc.getBadgeUser(event.id);
      result.fold((l) => 
        emit(UserBadgesSucssesState(badges: l)),
      (r) => emit(UserBadgesErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
