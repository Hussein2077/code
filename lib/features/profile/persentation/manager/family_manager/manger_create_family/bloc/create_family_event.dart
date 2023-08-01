
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class AbstracCreateFamilyEvent extends Equatable {
  const AbstracCreateFamilyEvent();

  @override
  List<Object> get props => [];
}

class CreateFamilyEvent extends AbstracCreateFamilyEvent {
  final String name;

  final File image;

  final String bio;

  const CreateFamilyEvent(
      {required this.name, required this.bio, required this.image});
}
