

import 'package:equatable/equatable.dart';

abstract class UseItemEvent extends Equatable {
  const UseItemEvent();

  @override
  List<Object> get props => [];
}

class UserItemsEvent extends UseItemEvent {
  final String id;
const  UserItemsEvent({required this.id});
}

class UnUsedItemEvent extends UseItemEvent {
  final String id;
  const UnUsedItemEvent({required this.id});
}
