
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';

abstract class BuyCoinsEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class BuyCoins extends BuyCoinsEvent{

 final BuyCoinsParameter buyCoinsParameter;

  BuyCoins({required this.buyCoinsParameter});
}


