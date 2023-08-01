



import 'package:tik_chat_v2/core/model/owner_data_model.dart';

abstract class GetFollowerOrFollowingState{
   final List<OwnerDataModel>? data ; 
   GetFollowerOrFollowingState(this.data);
  

}

class GetFollowerOrFollowingInitial extends GetFollowerOrFollowingState {
   GetFollowerOrFollowingInitial(super.data);
}
class GetFollowerOrFollowingLoadingState extends GetFollowerOrFollowingState {
    GetFollowerOrFollowingLoadingState(super.data);
}
class GetFollowerOrFollowingSucssesState extends GetFollowerOrFollowingState {
    GetFollowerOrFollowingSucssesState({required data}) : super(data);
}
class GetFollowerOrFollowingErrorState extends GetFollowerOrFollowingState {
  final String errorMassage ; 
   GetFollowerOrFollowingErrorState( super.data, this.errorMassage);
}
