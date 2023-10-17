


import 'package:tik_chat_v2/features/room_audio/data/model/lucky_gift_model.dart';

abstract class LuckyGiftBannerState   {
  const LuckyGiftBannerState();
  
 
}

 class LuckyGiftBannerInitial extends LuckyGiftBannerState {}

class SendLuckyGiftSucssesState extends LuckyGiftBannerState  {
 final int giftNum  ;
 final LuckyGiftModel data ;  
  final int isFirst ;




 
const SendLuckyGiftSucssesState({required this.isFirst ,  required this.data , required this.giftNum }) ;
}


class SendLuckyGiftErrorStateState extends LuckyGiftBannerState  {
 final String error  ; 
 
const SendLuckyGiftErrorStateState({required this.error}) ; 
}

class CloseLuckyGiftBanner extends LuckyGiftBannerState {

}