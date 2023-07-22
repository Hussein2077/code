

import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class BuyCoinsUseCase {
  BaseRepositoryProfile baseRepositoryProfile;

  BuyCoinsUseCase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> buyCoins(BuyCoinsParameter buyCoinsParameter) async {
    final result = await baseRepositoryProfile.buyCoins(buyCoinsParameter);
    return result;
  }
}

class BuyCoinsParameter extends Equatable {

  final String coinsID;

  final String paymentMethod;

  const BuyCoinsParameter({required this.coinsID, required this.paymentMethod,});

  @override
  List<Object> get props => [coinsID, paymentMethod];


}