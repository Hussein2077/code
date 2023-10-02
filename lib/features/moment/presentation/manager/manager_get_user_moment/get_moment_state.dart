
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class GetMomentUserState  {
  final List<MomentModel>? data ;

  GetMomentUserState(this.data);


}

class GetMomentUserInitial extends GetMomentUserState {
  GetMomentUserInitial(super.data);

}
class GetMomentUserLoadingState extends GetMomentUserState {
  GetMomentUserLoadingState(super.data);

}
class GetMomentUserSucssesState extends GetMomentUserState {
  GetMomentUserSucssesState({required data}) : super(data);


}
class GetMomentUserErrorState extends GetMomentUserState {
  final String errorMassage ;

  GetMomentUserErrorState( super.data, this.errorMassage);

}
