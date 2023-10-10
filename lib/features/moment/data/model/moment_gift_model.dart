class MomentGiftsModel{
  String? giftImage;
  int? giftId;
  int? giftNum;

  MomentGiftsModel({
    this.giftImage,
    this.giftId,
    this.giftNum,
  });

  factory MomentGiftsModel.fromjson(Map<String, dynamic> json) {
    return MomentGiftsModel(
      giftNum: json['num_gift'],
      giftId: json['pivot']['gift_id'],
      giftImage: json['img'],
    );
  }




}




