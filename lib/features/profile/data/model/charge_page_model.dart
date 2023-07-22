

class DataWalletModel   {
   final String diamonds ;
 final dynamic balance;
 final dynamic usdCoin;

   DataWalletModel(
      {required this.diamonds,
      required this.balance,
      required this.usdCoin});

  factory DataWalletModel.fromJson(Map<String,dynamic>jason ){

    return DataWalletModel(
        diamonds: jason['diamonds'],
        balance: jason['usd'],
        usdCoin: jason['usd_coin']
    );

  }
  

}
