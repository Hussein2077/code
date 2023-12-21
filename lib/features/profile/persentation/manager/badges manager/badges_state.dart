import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_badges_model.dart';

class GetBadgesStates extends Equatable {
  final List<GetBadgesModel> achievementBadge;
  final RequestState achievementBadgeRequest;
  final String achievementBadgeMessage;
  final List<GetBadgesModel> honorBadge;
  final RequestState honorBadgeRequest;
  final String honorBadgeMessage;
  final List<GetBadgesModel> activityBadge;
  final RequestState activityBadgeRequest;
  final String activityBadgeMessage;

  const GetBadgesStates(
      {this.achievementBadge = const [],
      this.achievementBadgeRequest = RequestState.loading,
      this.achievementBadgeMessage = "",
      this.honorBadge = const [],
      this.honorBadgeRequest = RequestState.loading,
      this.honorBadgeMessage = "",
      this.activityBadge = const [],
      this.activityBadgeRequest = RequestState.loading,
      this.activityBadgeMessage = ""});

  GetBadgesStates copyWith({
    List<GetBadgesModel>? achievementBadge,
    RequestState? achievementBadgeRequest,
    String? achievementBadgeMessage,
    List<GetBadgesModel>? honorBadge,
    RequestState? honorBadgeRequest,
    String? honorBadgeMessage,
    List<GetBadgesModel>? activityBadge,
    RequestState? activityBadgeRequest,
    String? activityBadgeMessage,
  }) {
    return GetBadgesStates(
      achievementBadge: achievementBadge ?? this.achievementBadge,
      achievementBadgeRequest:
          achievementBadgeRequest ?? this.achievementBadgeRequest,
      achievementBadgeMessage:
          achievementBadgeMessage ?? this.achievementBadgeMessage,
      honorBadge: honorBadge ?? this.honorBadge,
      honorBadgeRequest: honorBadgeRequest ?? this.honorBadgeRequest,
      honorBadgeMessage: honorBadgeMessage ?? this.honorBadgeMessage,
      activityBadge: activityBadge ?? this.activityBadge,
      activityBadgeRequest: activityBadgeRequest ?? this.activityBadgeRequest,
      activityBadgeMessage: activityBadgeMessage ?? this.activityBadgeMessage,
    );
  }

  @override
  List<Object?> get props => [
        achievementBadge,
        achievementBadgeRequest,
        achievementBadgeMessage,
        honorBadge,
        honorBadgeRequest,
        honorBadgeMessage,
        activityBadge,
        activityBadgeRequest,
        activityBadgeMessage,
      ];
}
