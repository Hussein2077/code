
import 'package:equatable/equatable.dart';

abstract class BaseUpdateUserDataEvent extends Equatable {
  const BaseUpdateUserDataEvent();
}

class UpdateUserDataEvent extends BaseUpdateUserDataEvent {
  final String name ;
  final String avatar ;
  const UpdateUserDataEvent({ required this.avatar , required this.name });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}