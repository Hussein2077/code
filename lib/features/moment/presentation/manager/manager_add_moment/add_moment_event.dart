
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BaseAddMomentEvent extends Equatable {
  const BaseAddMomentEvent();

  @override
  List<Object> get props => [];
}

class AddMomentEvent extends BaseAddMomentEvent {
  final String? moment;

  final File? momentImage;

  final String userId;

  const AddMomentEvent(
      { this.moment,  this.momentImage, required this.userId});
}