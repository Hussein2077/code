

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room/data/model/background_model.dart';

abstract class GetMyBackgroundState extends Equatable {
  const GetMyBackgroundState();
  
  @override
  List<Object> get props => [];
}

class GetMyBackgroundInitial extends GetMyBackgroundState {}
class GetMyBackgroundLodingState extends GetMyBackgroundState {}
class GetMyBackgroundSucssesState extends GetMyBackgroundState {
 final List<BackGroundModel> data;
  const  GetMyBackgroundSucssesState({required this.data});

}
class GetMyBackgroundErrorState extends GetMyBackgroundState {
  final String error ; 
 const GetMyBackgroundErrorState({required this.error});

}
