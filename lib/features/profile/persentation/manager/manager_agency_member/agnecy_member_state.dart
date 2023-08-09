

import 'package:tik_chat_v2/features/profile/data/model/agency_member_model.dart';

abstract class AgnecyMemberState  {
   final List<AgencyMemberModel>? data ;

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
