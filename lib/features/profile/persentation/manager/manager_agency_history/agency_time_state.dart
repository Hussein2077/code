
import 'package:tik_chat_v2/features/profile/data/model/agency_history_model.dart';

abstract class AgencyTimeState  {
  final AgencyHistoryModle? data ;

   AgencyTimeState(this.data);
  
 
}

class AgencyTimeInitial extends AgencyTimeState {
     AgencyTimeInitial(super.data);

}
class AgencyTimeLoadingState extends AgencyTimeState {
     AgencyTimeLoadingState(super.data);

}
class AgencyTimeSucssesState extends AgencyTimeState {
      AgencyTimeSucssesState({required data}) : super(data);



  
}
class AgencyTimeErrorState extends AgencyTimeState {
    final String error ; 

   AgencyTimeErrorState( super.data, this.error);



}
