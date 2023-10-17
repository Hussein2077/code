class LuckyGiftModel {
  final String message ; 
  final String giftImage ; 
  final String receiverName;
  final String winCoin;
  final bool isWin;
  final bool isPopular;
  final String coomentMesasge;



  const LuckyGiftModel({required this.giftImage , required this.message ,required this.receiverName ,     required this.winCoin,
    required this.isWin,
    required this.isPopular,
    required this.coomentMesasge,});

  factory LuckyGiftModel.fromJosn(Map <String , dynamic> json){
    return LuckyGiftModel(
      giftImage: json['data']['gift_image'],
      message: json['message'],
      receiverName: json['data']['receiver_name'],
      winCoin: json['data']['win_coins'].toString(),
      isWin: json['data']['is_win'],
      isPopular: json['data']['is_popular'],
      coomentMesasge: json['data']['comment_message'],
    );
  }
}