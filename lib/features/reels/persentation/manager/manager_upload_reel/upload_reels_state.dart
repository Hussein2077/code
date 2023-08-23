
import 'package:equatable/equatable.dart';

abstract class UploadReelsState extends Equatable {
  const UploadReelsState();
  
  @override
  List<Object> get props => [];
}

 class UploadReelsInitial extends UploadReelsState {}
 class UploadReelsLoadingState extends UploadReelsState {}
 class UploadReelsSucssesState extends UploadReelsState {
  final String message ; 
  const UploadReelsSucssesState ({required this.message});
 }
 class UploadReelsErrorState extends UploadReelsState {
  final String error ; 
  const UploadReelsErrorState ({required this.error });
 }
