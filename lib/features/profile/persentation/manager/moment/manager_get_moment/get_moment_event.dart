
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentEvent extends Equatable {
  const BaseGetMomentEvent();

  @override
  List<Object> get props => [];
}

class GetMomentEvent extends BaseGetMomentEvent {
  final String userId ; 
  const GetMomentEvent({required this.userId});
}