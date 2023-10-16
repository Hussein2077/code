
import 'package:flutter/animation.dart';

abstract class BaseLuckyGiftBannerEvent   {
  const BaseLuckyGiftBannerEvent();


}

class SendLuckyGiftEvent extends BaseLuckyGiftBannerEvent{
  final String ownerId;
  final  String id ;
  final String toUid ;
  final  String num ;
  SendLuckyGiftEvent({required this.ownerId , required this.id , required this.toUid , required this.num});

}


class EndBannerEvent extends BaseLuckyGiftBannerEvent{
 


}