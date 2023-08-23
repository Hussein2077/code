
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BaseUploadReelsEvent extends Equatable {
  const BaseUploadReelsEvent();

  @override
  List<Object> get props => [];
}

class UploadReelsEvent extends BaseUploadReelsEvent {
  final File reel ; 
  final String description ; 
  const UploadReelsEvent ({required this.description , required this.reel });
}