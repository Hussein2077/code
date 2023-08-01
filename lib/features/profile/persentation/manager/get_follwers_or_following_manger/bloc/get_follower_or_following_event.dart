

abstract class BaseGetFollowerOrFollowingEvent {
  const BaseGetFollowerOrFollowingEvent();


}


class GetFriendsOrFollowersOrFollwothemEvent extends BaseGetFollowerOrFollowingEvent {
  final String type;
 const GetFriendsOrFollowersOrFollwothemEvent({required this.type});
}

class GetMoreFriendsOrFollowersOrFollwothemEvent extends BaseGetFollowerOrFollowingEvent {
  final String type;
  final String page ; 
  const GetMoreFriendsOrFollowersOrFollwothemEvent({required this.type , required this.page });
}