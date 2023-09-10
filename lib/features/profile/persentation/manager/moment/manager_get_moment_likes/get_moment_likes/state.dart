



import 'package:equatable/equatable.dart';

abstract class GetMomentLikesStates extends Equatable{

  const GetMomentLikesStates();
  @override
  List<Object> get props => [];
}



class GetMomentLikesInitial extends GetMomentLikesStates{}
class GetMomentLikesLoadingState extends GetMomentLikesStates{


}
class GetMomentLikesSucssesState extends GetMomentLikesStates{
  String momentId;
  GetMomentLikesSucssesState({required this.momentId});
}
class GetMomentLikesErroeState extends GetMomentLikesStates{

  String message;
  GetMomentLikesErroeState({required this.message});
}
