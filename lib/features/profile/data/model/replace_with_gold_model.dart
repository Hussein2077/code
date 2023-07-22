
class ReplaceWithGoldModel {
  final int diomnds ; 
  final List<ReplaceWithGold> data ; 
  ReplaceWithGoldModel({required this.diomnds , required this.data});
  factory ReplaceWithGoldModel.fromjson(Map <String , dynamic > json){
    return ReplaceWithGoldModel(diomnds: json['message'] ,
      data: List<ReplaceWithGold>.from(
          json["data"].map((x) => ReplaceWithGold.fromjson(x))),);
  }
}
class ReplaceWithGold {
  final int id ; 
  final int coin ; 
  final int dimaond ; 
  ReplaceWithGold({required this.id , required this.coin , required this.dimaond});
  factory ReplaceWithGold.fromjson(Map <String , dynamic > json){
    return ReplaceWithGold(coin: json['value'] ,id: json['id'],  dimaond: json['diamonds'] );
  }
}