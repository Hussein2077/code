

class SilverCoinsModel{
final int silverCoin ; 
final  List<ItemSilverCoinsModel> data ; 
SilverCoinsModel({required this.data , required this.silverCoin});
factory SilverCoinsModel.fromjson(Map <String , dynamic > json){
  return SilverCoinsModel(silverCoin : json['message'],
   data: List<ItemSilverCoinsModel>.from(
          json["data"].map((x) => ItemSilverCoinsModel.fromjson(x))),
  
  );
   
}
}

class ItemSilverCoinsModel {
  final int id ; 
  final int coin ; 
  final int silver ; 
  ItemSilverCoinsModel({required this.id , required this.coin , required this.silver});
  factory ItemSilverCoinsModel.fromjson(Map <String , dynamic > json){
    return ItemSilverCoinsModel(coin: json['coin'] ,id: json['id'],  silver: json['silver'] );
  }
}