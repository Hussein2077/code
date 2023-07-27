
import 'package:equatable/equatable.dart';

abstract class BaseDeleteFamilyEvent extends Equatable {
  const BaseDeleteFamilyEvent();

  @override
  List<Object> get props => [];
}

class DeleteFamilyEvent extends BaseDeleteFamilyEvent {
  final String id;
  const DeleteFamilyEvent({required this.id});
}
