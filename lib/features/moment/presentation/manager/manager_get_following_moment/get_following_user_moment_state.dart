
// import 'package:equatable/equatable.dart';

// abstract class GetFollowingUserMomentState extends Equatable {
//   const GetFollowingUserMomentState();
  
//   @override
//   List<Object> get props => [];
// }

//  class GetFollowingUserMomentInitial extends GetFollowingUserMomentState {}






import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class GetFollowingUserMomentState  {
     final List<MomentModel>? data ;

    GetFollowingUserMomentState(this.data);
  

}

 class GetFollowingUserMomentInitial extends GetFollowingUserMomentState {
     GetFollowingUserMomentInitial(super.data);

 }
 class GetFollowingUserMomentLoadingState extends GetFollowingUserMomentState {
       GetFollowingUserMomentLoadingState(super.data);

 }
 class GetFollowingUserMomentSucssesState extends GetFollowingUserMomentState {
       GetFollowingUserMomentSucssesState({required data}) : super(data);

  
 }
 class GetFollowingUserMomentErrorState extends GetFollowingUserMomentState {
    final String errorMassage ; 

     GetFollowingUserMomentErrorState( super.data, this.errorMassage);

 }