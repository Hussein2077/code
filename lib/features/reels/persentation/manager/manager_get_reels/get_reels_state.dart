
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';

abstract class GetReelsState  {
     final List<ReelModel>? data ;

    GetReelsState(this.data);
  

}

 class GetReelsInitial extends GetReelsState {
     GetReelsInitial(super.data);

 }
 class GetReelsLoadingState extends GetReelsState {
       GetReelsLoadingState(super.data);

 }
 class GetReelsSucssesState extends GetReelsState {
       GetReelsSucssesState({required data}) : super(data);

  
 }
 class GetReelsErrorState extends GetReelsState {
    final String errorMassage ; 

     GetReelsErrorState( super.data, this.errorMassage);

 }
