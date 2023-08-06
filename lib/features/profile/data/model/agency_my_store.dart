class AgencyMyStoreModel {
  final int? coins ;
  final int? diamonds ; 
  final int? monthlyDiamonds ; 
  final int? silverCoins ; 
  final int? usd ; 
  final int? ownerUsd;

  const AgencyMyStoreModel ({
    this.coins , 
    this.diamonds,
    this.monthlyDiamonds , 
    this.silverCoins, 
    this.usd ,
    this.ownerUsd,

  });

  factory AgencyMyStoreModel.fromJson(Map <String , dynamic> json){
    return AgencyMyStoreModel(coins: 
    json["coins"]??0,
    diamonds: json["diamonds"]??0,
    monthlyDiamonds: json['monthly_diamonds']??0,
    silverCoins: json['silver_coins']??0,
    usd: json["usd"]??0,
    ownerUsd: json['owner_usd']??0,

    );

  }


}