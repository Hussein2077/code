
import 'package:equatable/equatable.dart';

abstract class BaseGetUserEvent extends Equatable {
  const BaseGetUserEvent();

  @override
  List<Object> get props => [];
}

class GetuserEvent extends BaseGetUserEvent {
 final String userId;
 bool? isVisit;
   GetuserEvent({  required this.userId,this.isVisit});

}

class InituserEvent extends BaseGetUserEvent {

  const InituserEvent();

}