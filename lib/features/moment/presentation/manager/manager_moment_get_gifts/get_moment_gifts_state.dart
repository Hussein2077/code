
import 'package:tik_chat_v2/features/moment/data/model/moment_gift_model.dart';

abstract class BaseGetMomentsGiftsStates {
  final List<MomentGiftsModel>? data ;
  BaseGetMomentsGiftsStates(this.data);
}
class GetMomentsGiftsInitialState extends BaseGetMomentsGiftsStates{
  GetMomentsGiftsInitialState(super.data);
}

class GetMomentsGiftsSuccessState extends BaseGetMomentsGiftsStates{

  GetMomentsGiftsSuccessState({required data}) : super(data);
}
class GetMomentsGiftsErrorState extends BaseGetMomentsGiftsStates{
  String errorMessage;
  GetMomentsGiftsErrorState(super.data,  this.errorMessage);

}
class GetMomentsGiftsloadingState extends BaseGetMomentsGiftsStates{
  GetMomentsGiftsloadingState(super.data);

}


