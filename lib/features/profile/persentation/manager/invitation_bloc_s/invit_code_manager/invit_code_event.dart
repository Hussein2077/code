
import 'package:equatable/equatable.dart';

abstract class InvitCodeEvents extends Equatable {
  const InvitCodeEvents();

  @override
  List<Object> get props => [];
}
class InvitCodeEvent extends InvitCodeEvents {
  final String id;
  const InvitCodeEvent({required this.id, });
}
class InvitCodeEventInitial extends InvitCodeEvents {
}