class AgencyMyStoreModel {
  final int? coins ;
  final int? diamonds ; 
  final int? monthlyDiamonds ; 
  final int? silverCoins ; 
  final int? usd ; 

  const AgencyMyStoreModel ({
    this.coins , 
    this.diamonds,
    this.monthlyDiamonds , 
    this.silverCoins, 
    this.usd 

  });

  factory AgencyMyStoreModel.fromJson(Map <String , dynamic> json){
    return AgencyMyStoreModel(coins: 
    json["coins"]??0,
    diamonds: json["diamonds"]??0,
    monthlyDiamonds: json['monthly_diamonds']??0,
    silverCoins: json['silver_coins']??0,
    usd: json["usd"]??0,

    );

  }


}