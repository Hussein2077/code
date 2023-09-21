import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/data/model/get_room_users_model.dart';
import 'package:tik_chat_v2/features/room/data/model/gifts_model.dart';


abstract class OnRoomStates extends Equatable {
  const OnRoomStates();

  @override
  List<Object?> get props => [];
}

class OnRoomInitialState extends OnRoomStates{
  const OnRoomInitialState ();
}
class OnRoomLoadingState extends OnRoomStates{
  const OnRoomLoadingState();
}

class ExitRoomErrorMessageState extends OnRoomStates {
  final String errorMessage;

  const ExitRoomErrorMessageState({required this.errorMessage});
}

class ExitRoomSuccesMessageState extends OnRoomStates {
  final String succesMessage;

  const ExitRoomSuccesMessageState({required this.succesMessage});
}


class GetBackGroundloadingState extends OnRoomStates {}

class GetBackGroundErrorState extends OnRoomStates {
  final String errorMassage;
  const GetBackGroundErrorState({required this.errorMassage});
}

class GetBackGroundSucsseState extends OnRoomStates {
final  List<BackGroundModel> data;
 const GetBackGroundSucsseState({required this.data});
}

class UpdateRoomLoadingState extends OnRoomStates{}

class UpdateRoomErrorState extends OnRoomStates {
  final String errorMassage;
  const UpdateRoomErrorState({required this.errorMassage});
}

class UpdateRoomSucsseState extends OnRoomStates {
 final EnterRoomModel data;
 const UpdateRoomSucsseState({required this.data});
}
class GetEmojieLoadingState extends OnRoomStates{

}

class GetEmojieErrorState extends OnRoomStates {
  final String errorMassage;
  const GetEmojieErrorState({required this.errorMassage});
}

class GetEmojieSucssesState extends OnRoomStates {
 final List<EmojieModel> data;
  const GetEmojieSucssesState({required this.data});
}

class GiftesLoadingState extends OnRoomStates{

}

class GiftesErrorState extends OnRoomStates {
  final String errorMassage;
  const GiftesErrorState({required this.errorMassage});
}

class GiftesSucssesState extends OnRoomStates {
 final List<GiftsModel> data;
 const GiftesSucssesState({required this.data});
}



class RemovePassRoomLoadingState extends OnRoomStates{

}

class RemovePassRoomErrorState extends OnRoomStates {
  final String errorMassage;
  const RemovePassRoomErrorState({required this.errorMassage});
}

class RemovePassRoomSucssesState extends OnRoomStates {
  final String succecMassage;
  const RemovePassRoomSucssesState({required this.succecMassage});
}

class UpMicLoadingState extends OnRoomStates{

}

class UpMicErrorState extends OnRoomStates {
  final String errorMassage;
  const UpMicErrorState({required this.errorMassage});
}

class UpMicSucssesState extends OnRoomStates {
  final String succecMassage;
  const UpMicSucssesState({required this.succecMassage});
}

class LeaveMicLoadingState extends OnRoomStates{

}

class LeaveMicErrorState extends OnRoomStates {
  final String errorMassage;
  const LeaveMicErrorState({required this.errorMassage});
}

class LeaveMicSucssesState extends OnRoomStates {
  final String succecMassage;
  const LeaveMicSucssesState({required this.succecMassage});
}

class MuteMicLoadingState extends OnRoomStates{

}

class MuteMicErrorState extends OnRoomStates {
  final String errorMassage;
  const MuteMicErrorState({required this.errorMassage});
}

class MuteMicSucssesState extends OnRoomStates {
  final String succecMassage;
  const MuteMicSucssesState({required this.succecMassage});
}

class UnMuteMicLoadingState extends OnRoomStates{

}

class UnMuteMicErrorState extends OnRoomStates {
  final String errorMassage;
  const UnMuteMicErrorState({required this.errorMassage});
}

class UnMuteMicSucssesState extends OnRoomStates {
  final String succecMassage;
  const UnMuteMicSucssesState({required this.succecMassage});
}

class LockMicLoadingState extends OnRoomStates{

}

class LockMicErrorState extends OnRoomStates {
  final String errorMassage;
  const LockMicErrorState({required this.errorMassage});
}

class LockMicSucssesState extends OnRoomStates {
  final String succecMassage;
  const LockMicSucssesState({required this.succecMassage});
}

class UnLockMicLoadingState extends OnRoomStates{

}

class UnLockMicErrorState extends OnRoomStates {
  final String errorMassage;
  const UnLockMicErrorState({required this.errorMassage});
}

class UnLockMicSucssesState extends OnRoomStates {
  final String succecMassage;
  const UnLockMicSucssesState({required this.succecMassage});
}

class ChangeModeRoomLoadingState extends OnRoomStates{

}

class ChangeModeRoomErrorState extends OnRoomStates {
  final String errorMassage;
  const ChangeModeRoomErrorState({required this.errorMassage});
}

class ChangeModeRoomSuccessState extends OnRoomStates {
  final String succecMassage;
  const ChangeModeRoomSuccessState({required this.succecMassage});
}

class RemoveChatRoomLoadingState extends OnRoomStates{

}

class RemoveChatRoomErrorState extends OnRoomStates {
  final String errorMassage;
  const RemoveChatRoomErrorState({required this.errorMassage});
}

class RemoveChatRoomSuccessState extends OnRoomStates {


}

class BanUserFromWritingLoadingState extends OnRoomStates{

}

class BanUserFromWritingErrorState extends OnRoomStates {
  final String errorMassage;
  const BanUserFromWritingErrorState({required this.errorMassage});
}

class BanUserFromWritingSuccessState extends OnRoomStates {
  final String successMassage;
  const BanUserFromWritingSuccessState({required this.successMassage});

}

class SendPobUpLoadingState extends OnRoomStates{

}

class SendPobUpErrorState extends OnRoomStates {
  final String errorMassage;
  const SendPobUpErrorState({required this.errorMassage});
}

class SendPobUpSuccessState extends OnRoomStates {
  final String successMassage;
  const SendPobUpSuccessState({required this.successMassage});
}

class HideRoomLoadingState extends OnRoomStates{

}

class HideRoomErrorState extends OnRoomStates {
  final String errorMassage;
  const HideRoomErrorState({required this.errorMassage});
}

class HideRoomSuccessState extends OnRoomStates {
  final String successMassage;
  const HideRoomSuccessState({required this.successMassage});
}

class DisposeHideRoomLoadingState extends OnRoomStates{

}

class DisposeHideRoomErrorState extends OnRoomStates {
  final String errorMassage;
  const DisposeHideRoomErrorState({required this.errorMassage});
}

class  DisposeHideRoomSuccessState extends OnRoomStates {
  final String successMassage;
  const DisposeHideRoomSuccessState({required this.successMassage});
}

class SendYallowBannerLoadingState extends OnRoomStates{

}

class SendYallowBannerErrorState extends OnRoomStates {
  final String errorMassage;
  const SendYallowBannerErrorState({required this.errorMassage});
}

class SendYallowBannerSuccessState extends OnRoomStates {
  final String successMassage;
  const SendYallowBannerSuccessState({required this.successMassage});
}