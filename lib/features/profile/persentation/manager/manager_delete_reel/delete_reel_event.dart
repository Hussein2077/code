
import 'package:equatable/equatable.dart';

abstract class BasseDeleteReelEvent extends Equatable {
  const BasseDeleteReelEvent();

  @override
  List<Object> get props => [];
}

class DeleteReelEvent extends BasseDeleteReelEvent {
  
  final String id ; 
  const DeleteReelEvent ({required this.id});

}