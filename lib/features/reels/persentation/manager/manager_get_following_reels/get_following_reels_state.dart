
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';

abstract class GetFollowingReelsState  {
  final List<ReelModel>? data ;

  GetFollowingReelsState(this.data);

}

class GetFollowingReelsInitial extends GetFollowingReelsState {
  GetFollowingReelsInitial(super.data);
}

class GetFollowingReelsLoadingState extends GetFollowingReelsState {
  GetFollowingReelsLoadingState(super.data);
}

class GetFollowingReelsSucssesState extends GetFollowingReelsState {
  GetFollowingReelsSucssesState({required data}) : super(data);
}

class GetFollowingReelsErrorState extends GetFollowingReelsState {
  final String errorMassage ;
  GetFollowingReelsErrorState( super.data, this.errorMassage);
}
