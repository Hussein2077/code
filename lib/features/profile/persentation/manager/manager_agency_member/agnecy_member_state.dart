

import 'package:tik_chat_v2/core/model/owner_data_model.dart';

abstract class AgnecyMemberState  {
   final List<OwnerDataModel>? data ;

  const AgnecyMemberState( this.data);
  

}

class AgnecyMemberInitial extends AgnecyMemberState {
  AgnecyMemberInitial(super.data);
}
class AgnecyMemberLoadingState extends AgnecyMemberState {
  AgnecyMemberLoadingState(super.data);
}
class AgnecyMemberSucsessState extends AgnecyMemberState {

  AgnecyMemberSucsessState({required data}) : super(data);
 
}
class AgnecyMemberErrorState extends AgnecyMemberState {
  final String error ; 
  const AgnecyMemberErrorState( this.error , super.data );
}
