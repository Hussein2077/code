

import 'package:equatable/equatable.dart';

abstract class BaseAddInterstedEvent extends Equatable {
  const BaseAddInterstedEvent();

  @override
  List<Object> get props => [];
}

class AddInterstedEvent extends BaseAddInterstedEvent {
  final List<int> ids ; 
  const AddInterstedEvent({required this.ids});
}