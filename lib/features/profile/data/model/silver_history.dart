class SilverCoinHistory {
  final String time ; 
  final int coin ; 
  final int silver ; 
  SilverCoinHistory({required this.time , required this.coin , required this.silver});
  factory SilverCoinHistory.fromjson(Map <String , dynamic > json){
    return SilverCoinHistory(coin: json['coins'] ,time: json['time'],  silver: json['silvers'] );
  }
}