class AgencyMyStoreModel {
  final int? coins ;
  final int? diamonds ;
  // final int? monthlyDiamonds ;
  final int? silverCoins ; 
  final int? hostUsd ;
  final int? userUsd ;
  // final int? ownerUsd;

  const AgencyMyStoreModel ({
    this.coins , 
    this.diamonds,
    // this.monthlyDiamonds ,
    this.silverCoins, 
    this.userUsd,
    this.hostUsd ,
    // this.ownerUsd,

  });

  factory AgencyMyStoreModel.fromJson(Map <String , dynamic> json){
    return AgencyMyStoreModel(coins: 
    json["coins"]??0,
    diamonds: json["diamonds"]??0,
    // monthlyDiamonds: json['monthly_diamonds']??0,
    silverCoins: json['silver_coins']??0,
    hostUsd: json["host_usd"]??0,
      userUsd: json["user_usd"]??0,
    // ownerUsd: json['owner_usd']??0,
    );
  }
}