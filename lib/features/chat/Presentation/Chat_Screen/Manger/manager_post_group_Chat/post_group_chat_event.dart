
import 'package:equatable/equatable.dart';

abstract class BaseGroupChatEvent extends Equatable {
  const BaseGroupChatEvent();

  @override
  List<Object> get props => [];
}
 class PostGroupChatEvent extends BaseGroupChatEvent{
  final String massage ; 
  const PostGroupChatEvent({required this.massage});
 }