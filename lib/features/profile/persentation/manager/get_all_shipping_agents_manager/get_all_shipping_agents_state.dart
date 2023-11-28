import 'package:tik_chat_v2/core/model/user_data_model.dart';

abstract class AllShippingAgentsState{
  final List<UserDataModel>? data ;
  AllShippingAgentsState(this.data);
}

class GetAllShippingAgentsInitialState extends AllShippingAgentsState {
  GetAllShippingAgentsInitialState(super.data);
}
class GetAllShippingAgentsLoadinglState extends AllShippingAgentsState {
  GetAllShippingAgentsLoadinglState(super.data);
}
class GetAllShippingAgentsSucssesState extends AllShippingAgentsState {
  GetAllShippingAgentsSucssesState({required data}) : super(data);
}
class GetAllShippingAgentsErrorState extends AllShippingAgentsState {
  final String errorMassage ;
  GetAllShippingAgentsErrorState(super.data, this.errorMassage);
}
