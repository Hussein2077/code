import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class GetMomentOtherUserState {
  final List<MomentModel>? data;

  GetMomentOtherUserState(this.data);
}

class GetMomentOtherUserInitial extends GetMomentOtherUserState {
  GetMomentOtherUserInitial(super.data);
}

class GetMomentOtherUserLoadingState extends GetMomentOtherUserState {
  GetMomentOtherUserLoadingState(super.data);
}

class GetMomentOtherUserSucssesState extends GetMomentOtherUserState {
  GetMomentOtherUserSucssesState({required data}) : super(data);
}

class GetMomentOtherUserErrorState extends GetMomentOtherUserState {
  final String errorMassage;

  GetMomentOtherUserErrorState(super.data, this.errorMassage);
}
