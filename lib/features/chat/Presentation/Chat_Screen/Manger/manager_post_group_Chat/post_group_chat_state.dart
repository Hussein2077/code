
import 'package:equatable/equatable.dart';

abstract class GroupChatState extends Equatable {
  const GroupChatState();
  
  @override
  List<Object> get props => [];
}

class GroupChatInitial extends GroupChatState {}
 class PostGroupChatLoading extends GroupChatState {}
class PostGroupChatSucsses extends GroupChatState {
  final String massage ; 
  const PostGroupChatSucsses({required this.massage});
}
class PostGroupChatError extends GroupChatState {

  final String error ; 
  const PostGroupChatError ({required this.error});
}
