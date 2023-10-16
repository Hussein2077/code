class LuckyGiftModel {
  final String message ; 
  final String giftImage ; 
  final String receiverName;



  const LuckyGiftModel({required this.giftImage , required this.message ,required this.receiverName});

  factory LuckyGiftModel.fromJosn(Map <String , dynamic> json){
    return LuckyGiftModel(
      giftImage: json['data']['gift_image'],
      message: json['message'],
      receiverName: json['data']['receiver_name'],
    );
  }
}