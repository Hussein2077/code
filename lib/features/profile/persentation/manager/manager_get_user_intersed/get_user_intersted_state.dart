
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/intrested_model.dart';

abstract class GetUserInterstedState extends Equatable {
  const GetUserInterstedState();
  
  @override
  List<Object> get props => [];
}

 class GetUserInterstedInitial extends GetUserInterstedState {}
 class GetUserInterstedLoadingState extends GetUserInterstedState {}
 class GetUserInterstedSucssesState extends GetUserInterstedState {
    final List <InterstedMode> data ; 
  const GetUserInterstedSucssesState({required this.data });

 }
 class GetUserInterstedErrorState extends GetUserInterstedState {
  final String error ;
  const GetUserInterstedErrorState({required this.error});
 }
