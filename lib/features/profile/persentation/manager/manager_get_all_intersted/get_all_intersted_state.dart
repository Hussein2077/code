
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/intrested_model.dart';

abstract class GetAllInterstedState extends Equatable {
  const GetAllInterstedState();
  
  @override
  List<Object> get props => [];
}

 class GetAllInterstedInitial extends GetAllInterstedState {}

 class GetAllInterstedLoadingState extends GetAllInterstedState {}

 class GetAllInterstedSucssesState extends GetAllInterstedState {
  final List <InterstedMode> data ; 
  const GetAllInterstedSucssesState({required this.data });
 }

 class GetAllInterstedErrorState extends GetAllInterstedState {
  final String error ; 
  const GetAllInterstedErrorState({required this.error });
 }
