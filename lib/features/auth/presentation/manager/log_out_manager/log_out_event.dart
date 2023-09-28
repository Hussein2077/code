
import 'package:equatable/equatable.dart';

abstract class BaseLogOutEvent extends Equatable {
  const BaseLogOutEvent();

  @override
  List<Object> get props => [];
}


class LogOutEvent extends BaseLogOutEvent {}

class DeleteAccountEvent extends BaseLogOutEvent{}