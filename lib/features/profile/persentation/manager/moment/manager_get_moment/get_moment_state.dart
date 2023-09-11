
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/moment/moment_model.dart';

abstract class GetMomentState extends Equatable {
  const GetMomentState();
  
  @override
  List<Object> get props => [];
}

 class GetMomentInitial extends GetMomentState {}
 class GetMomentLoadingState extends GetMomentState {

 }
 class GetMomentSucssesState extends GetMomentState {
  final List<MomentModel> data ; 
  const GetMomentSucssesState({required this.data});
 }
 class GetMomentErrorState extends GetMomentState {
  final String error ; 
  const GetMomentErrorState({required this.error});
 }
