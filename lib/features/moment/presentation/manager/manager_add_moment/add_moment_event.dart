
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseAddMomentEvent extends Equatable {
  const BaseAddMomentEvent();

  @override
  List<Object> get props => [];
}

class AddMomentEvent extends BaseAddMomentEvent {
  final String moment ; 
  final String userId ; 
  final XFile momentImage ;

  const AddMomentEvent({
    required this.moment ,
    required this.momentImage ,
    required this.userId});
}