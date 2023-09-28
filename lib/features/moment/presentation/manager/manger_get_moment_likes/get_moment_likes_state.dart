








import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';

abstract class GetMomentLikesState  {
     final List<MomentLikeModel>? data ;

    GetMomentLikesState(this.data);
  

}

 class GetMomentLikeInitial extends GetMomentLikesState {
     GetMomentLikeInitial(super.data);

 }
 class GetMomentLikeLoadingState extends GetMomentLikesState {
       GetMomentLikeLoadingState(super.data);

 }
 class GetMomentLikeSucssesState extends GetMomentLikesState {
       GetMomentLikeSucssesState({required data}) : super(data);

  
 }
 class GetMomentLikeErrorState extends GetMomentLikesState {
    final String errorMassage ; 

     GetMomentLikeErrorState( super.data, this.errorMassage);

 }
