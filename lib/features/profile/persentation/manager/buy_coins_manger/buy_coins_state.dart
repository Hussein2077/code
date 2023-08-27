
abstract class BuyCoinsState {}

class BuyCoinsInitial extends BuyCoinsState {}


class BuyCoinsLoadingState extends BuyCoinsState {}

class BuyCoinsErrorState extends BuyCoinsState {
  final String error;
   BuyCoinsErrorState({required this.error});
}

class BuyCoinsSuccessState extends BuyCoinsState {
  final String susses;
   BuyCoinsSuccessState({required this.susses});
}

