import 'package:equatable/equatable.dart';

abstract class BaseAddOrDeleteBlockListEvent extends Equatable {
  const BaseAddOrDeleteBlockListEvent();

  @override
  List<Object> get props => [];
}

class DeleteBlockListEvent extends BaseAddOrDeleteBlockListEvent {
 final String userID;

  const DeleteBlockListEvent(this.userID);
}
class AddBlockListEvent extends BaseAddOrDeleteBlockListEvent {
  final String userID;

  const AddBlockListEvent(this.userID);
}
