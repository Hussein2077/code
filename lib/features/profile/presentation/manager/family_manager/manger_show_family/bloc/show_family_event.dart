
import 'package:equatable/equatable.dart';

abstract class BaseShowFamilyEvent extends Equatable {
  const BaseShowFamilyEvent();

  @override
  List<Object> get props => [];
}

class ShowFamilyEvent extends BaseShowFamilyEvent {
  final String id;
  const ShowFamilyEvent({required this.id});
}
