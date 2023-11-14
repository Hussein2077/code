
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/chat/data/models/group_chat_model.dart';

abstract class BaseGetGroupMassageEvent  {
  const BaseGetGroupMassageEvent();


}

class GetGroupMassageEvent extends BaseGetGroupMassageEvent{
  

}

class GetMoreGroupMassageEvent extends BaseGetGroupMassageEvent{
  final String page ; 
const  GetMoreGroupMassageEvent({required this.page});

}

class GetGroupChatMessageReelTime extends BaseGetGroupMassageEvent {
  final GroupChatModel message ;
 const GetGroupChatMessageReelTime ({required this.message});

}