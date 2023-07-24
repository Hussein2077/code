class GiftHistoryModel {
  final String num ; 
final GiftHistoryItemModel data ;
  GiftHistoryModel({required this.num , required this.data });
  factory GiftHistoryModel.fromjson(Map <String , dynamic > json){
    return GiftHistoryModel(num: json['num'] , data:GiftHistoryItemModel.fromjson(json['gift'])  );
  }
}


class GiftHistoryItemModel {
  final String img ; 
  
  GiftHistoryItemModel({required this.img });
  factory GiftHistoryItemModel.fromjson(Map <String , dynamic > json){
    return GiftHistoryItemModel(img: json['img'] );
  }
}