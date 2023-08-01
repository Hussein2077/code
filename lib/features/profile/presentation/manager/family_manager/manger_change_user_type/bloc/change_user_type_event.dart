
import 'package:equatable/equatable.dart';

abstract class BaseChangeUserTypeEvent extends Equatable {
  const BaseChangeUserTypeEvent();

  @override
  List<Object> get props => [];
}

class ChangeUserTypeEvent extends BaseChangeUserTypeEvent {
  final String userId;
  final String familyId;
  final String type;
  const ChangeUserTypeEvent(
      {required this.userId, required this.familyId, required this.type});
}
