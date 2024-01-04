import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BaseAddInfoEvent extends Equatable {
  const BaseAddInfoEvent();

  @override
  List<Object> get props => [];
}

class AddInfoEvent extends BaseAddInfoEvent {
  final String? bio;
  final String? name;
  final String? date;
  final File? image;
  final int? gender;
  final int? countryID;
  final String? age;
  final String? email;

  const AddInfoEvent(
      {this.bio,
      this.gender,
      this.name,
      this.date,
      this.countryID,
      this.email,
      this.image,
      this.age});
}
