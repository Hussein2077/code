
import 'package:equatable/equatable.dart';

import '../../../../data/models/group_chat_model.dart';

abstract class GetGroupMassageState  {
  final List<GroupChatModel>? data ;
   GetGroupMassageState(this.data);
  

}

class GetGroupMassageInitial extends GetGroupMassageState {
   GetGroupMassageInitial(super.data);
}
class GetGroupMassageLoading extends GetGroupMassageState {
 GetGroupMassageLoading(super.data);

}

class GetGroupMassageSucsses extends GetGroupMassageState {
    GetGroupMassageSucsses({required data}) : super(data);
}

class GetGroupMassageError extends GetGroupMassageState {
  final String errorMassage ; 
   GetGroupMassageError( super.data, this.errorMassage);
}

