
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';

abstract class GetReelsCommentsState  {
     final List<ReelCommentModel>? data ;

    GetReelsCommentsState(this.data);
  

}

 class GetReelsCommentsInitial extends GetReelsCommentsState {
     GetReelsCommentsInitial(super.data);

 }
 class GetReelsCommentsLoadingState extends GetReelsCommentsState {
       GetReelsCommentsLoadingState(super.data);

 }
 class GetReelsCommentsSucssesState extends GetReelsCommentsState {
       GetReelsCommentsSucssesState({required data}) : super(data);

  
 }
 class GetReelsCommentsErrorState extends GetReelsCommentsState {
    final String errorMassage ; 

     GetReelsCommentsErrorState( super.data, this.errorMassage);

 }