import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_friends_or_followers.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_state.dart';

class GetFollowerOrFollowingBloc
    extends Bloc<BaseGetFollowerOrFollowingEvent, GetFollowerOrFollowingState> {
  final GetFriendsOrFollowersUsecase getFriendsOrFollowersUsecase;
  bool isLoadingMore = false;
  GetFollowerOrFollowingBloc({required this.getFriendsOrFollowersUsecase})
      : super(GetFollowerOrFollowingInitial(null)) {
    on<GetFriendsOrFollowersOrFollwothemEvent>((event, emit) async {
      emit(GetFollowerOrFollowingLoadingState(null));
      final result = await getFriendsOrFollowersUsecase.getFriendsOrFollowers(
          type: event.type);

      result.fold((l) {
        emit(GetFollowerOrFollowingErrorState(
          null,
          DioHelper().getTypeOfFailure(l),
        ));
      }, (r) {
        emit(GetFollowerOrFollowingSucssesState(data: r));
      });
    });
    on<GetMoreFriendsOrFollowersOrFollwothemEvent>((event, emit) async {
      isLoadingMore = true;
      emit(GetFollowerOrFollowingSucssesState(data: [
        ...state.data!,
      ]));

      var result = await getFriendsOrFollowersUsecase.getFriendsOrFollowers(
          type: event.type, page: event.page);
      result.fold((l) {
        isLoadingMore = false;
        emit(GetFollowerOrFollowingErrorState(
            null, DioHelper().getTypeOfFailure(l)));
      }, (r) {
        isLoadingMore = false;

        if (r != []) {
          emit(
              GetFollowerOrFollowingSucssesState(data: [...state.data!, ...r]));
        }
      });
    });
  }
}
