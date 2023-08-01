
import 'package:equatable/equatable.dart';

abstract class BaseGetUserEvent extends Equatable {
  const BaseGetUserEvent();

  @override
  List<Object> get props => [];
}

class GetuserEvent extends BaseGetUserEvent {
 final String userId;

 const  GetuserEvent({  required this.userId});

}

class InituserEvent extends BaseGetUserEvent {

  const InituserEvent();

}