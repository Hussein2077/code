
import 'package:equatable/equatable.dart';

abstract class BaseGetGroupMassageEvent  {
  const BaseGetGroupMassageEvent();


}

class GetGroupMassageEvent extends BaseGetGroupMassageEvent{
  

}

class GetMoreGroupMassageEvent extends BaseGetGroupMassageEvent{
  final String page ; 
const  GetMoreGroupMassageEvent({required this.page});

}