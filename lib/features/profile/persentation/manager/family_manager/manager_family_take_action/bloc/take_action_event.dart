
import 'package:equatable/equatable.dart';

abstract class BaseTakeActionEvent extends Equatable {
  const BaseTakeActionEvent();

  @override
  List<Object> get props => [];
}

class FamilyTakeActionEvent extends BaseTakeActionEvent {
  final String reqId;
  final String status;
  const FamilyTakeActionEvent({
    required this.reqId,
    required this.status,
  });
}
