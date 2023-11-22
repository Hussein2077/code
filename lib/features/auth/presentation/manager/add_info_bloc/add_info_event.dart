
import 'dart:io';

import 'package:equatable/equatable.dart';


abstract class BaseAddInfoEvent extends Equatable {
  const BaseAddInfoEvent();

  @override
  List<Object> get props => [];
}

class AddInfoEvent extends BaseAddInfoEvent {
    final String? bio ;
    final String name ;
  final String? date ;
  final File? image ;
  final String gender ;
  final int? countryID ;
  final String? age ;

   const AddInfoEvent( { this.bio ,  required  this.gender
    ,required  this.name,  this.date, this.countryID,
    this.image, this.age});
}