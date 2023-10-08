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
      giftNum: json['userid'],
      giftId: json['userid'],
      giftImage: json['userid'],
    );
  }




  }




