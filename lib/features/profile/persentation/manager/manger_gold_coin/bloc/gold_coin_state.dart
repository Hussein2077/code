
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/gold_coin_model.dart';


abstract class GoldCoinState extends Equatable {
  const GoldCoinState();
  
  @override
  List<Object> get props => [];
}

class GoldCoinInitial extends GoldCoinState {}
class GoldCoinLoadingState extends GoldCoinState {}
class GoldCoinSucssesState extends GoldCoinState {
 final List<GoldCoinsModel> data ; 
const GoldCoinSucssesState({required this.data});
}
class GoldCoinErrorState extends GoldCoinState {
  final String error ; 
  const GoldCoinErrorState({required this.error});
}

class RechargeCoinLoadingState extends GoldCoinState {}
class RechargeCoinSucssesState extends GoldCoinState {
  final String urlWeb ;
  const RechargeCoinSucssesState({required this.urlWeb});
}
class RechargeCoinErrorState extends GoldCoinState {
  final String measssageError ;
  const RechargeCoinErrorState({required this.measssageError});
}