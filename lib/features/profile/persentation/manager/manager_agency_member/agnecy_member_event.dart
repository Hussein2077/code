
import 'package:equatable/equatable.dart';

abstract class BaseAgnecyMemberEvent extends Equatable {
  const BaseAgnecyMemberEvent();

  @override
  List<Object> get props => [];
}

class AgnecyMemberEvent extends BaseAgnecyMemberEvent {
  final int page ; 
  const AgnecyMemberEvent({required this.page});
}

class LoadMoreAgnecyMemberEvent extends BaseAgnecyMemberEvent {
  final int page ; 
  const LoadMoreAgnecyMemberEvent({required this.page});
}