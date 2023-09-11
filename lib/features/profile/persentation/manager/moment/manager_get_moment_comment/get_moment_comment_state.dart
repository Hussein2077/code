
import 'package:tik_chat_v2/features/profile/data/model/moment/moment_comment_model.dart';




abstract class GetMomentCommentState  {
     final List<MomentCommentModel>? data ;

    GetMomentCommentState(this.data);
  

}

 class GetMomentCommentInitial extends GetMomentCommentState {
     GetMomentCommentInitial(super.data);

 }
 class GetMomentCommentLoadingState extends GetMomentCommentState {
       GetMomentCommentLoadingState(super.data);

 }
 class GetMomentCommentSucssesState extends GetMomentCommentState {
       GetMomentCommentSucssesState({required data}) : super(data);

  
 }
 class GetMomentCommentErrorState extends GetMomentCommentState {
    final String errorMassage ; 

     GetMomentCommentErrorState( super.data, this.errorMassage);

 }
