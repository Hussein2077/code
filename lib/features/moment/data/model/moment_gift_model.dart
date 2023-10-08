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
      giftNum: json['gift_num'],
      giftId: json['gift_id'],
      giftImage: json['img'],
    );
  }




}




