class GoldCoinsModel {
  final int id ; 
  final dynamic coin ; 
  final dynamic usd ; 
  GoldCoinsModel({required this.id , required this.coin , required this.usd});
  factory GoldCoinsModel.fromjson(Map <String , dynamic > json){
    return GoldCoinsModel(coin: json['coin'] ,id: json['id'],  usd: json['usd'] );
  }
}