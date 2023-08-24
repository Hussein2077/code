


import 'package:tik_chat_v2/core/model/user_data_model.dart';

abstract class VistorsState  {
     final List<UserDataModel>? data ;

  const VistorsState(this.data);


}

class VistorsInitial extends VistorsState {
     VistorsInitial(super.data);

}

class GetVistorsLoadingState extends VistorsState {
     GetVistorsLoadingState(super.data);


}

class GetVistorsErrorState extends VistorsState {
  final String errorMassage ; 
   GetVistorsErrorState( super.data, this.errorMassage);
}

class GetVistorsSucssesState extends VistorsState {
    GetVistorsSucssesState({required data}) : super(data);
}
