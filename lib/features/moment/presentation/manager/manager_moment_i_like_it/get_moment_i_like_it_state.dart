










import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class GetMomentILikeItUserState  {
     final List<MomentModel>? data ;

    GetMomentILikeItUserState(this.data);
  

}

 class GetMomentILikeItInitial extends GetMomentILikeItUserState {
     GetMomentILikeItInitial(super.data);

 }
 class GetMomentILikeItLoadingState extends GetMomentILikeItUserState {
       GetMomentILikeItLoadingState(super.data);

 }
 class GetMomentILikeItSucssesState extends GetMomentILikeItUserState {
       GetMomentILikeItSucssesState({required data}) : super(data);

  
 }
 class GetMomentILikeItErrorState extends GetMomentILikeItUserState {
    final String errorMassage ; 

     GetMomentILikeItErrorState( super.data, this.errorMassage);

 }
