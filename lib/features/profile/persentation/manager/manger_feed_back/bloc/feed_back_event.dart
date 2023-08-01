import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class BasseFeedBackEvent extends Equatable {
  const BasseFeedBackEvent();

  @override
  List<Object> get props => [];
}

class FeedBackEvent extends BasseFeedBackEvent{
  final String content;
  final String phoneNumber;
  final File? image ;
  final int? userId ;
  final String? description ; 
  const FeedBackEvent({this.description,  required this.content , required this.phoneNumber ,this.image,this.userId});
}