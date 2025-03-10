
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';

abstract class GetUserReelsState  {
     final List<ReelModel>? data ;

    GetUserReelsState(this.data);
  

}

 class GetUserReelsInitial extends GetUserReelsState {
     GetUserReelsInitial(super.data);

 }
 class GetUserReelsLoadingState extends GetUserReelsState {
       GetUserReelsLoadingState(super.data);

 }
 class GetUserReelsSucssesState extends GetUserReelsState {
  bool loadMore;
  GetUserReelsSucssesState({required data, required this.loadMore}) : super(data);

  
 }
 class GetReelUsersErrorState extends GetUserReelsState {
    final String errorMassage ; 

     GetReelUsersErrorState( super.data, this.errorMassage);

 }

class NoMoreReelsState extends GetUserReelsState {
  NoMoreReelsState(super.data);
}
