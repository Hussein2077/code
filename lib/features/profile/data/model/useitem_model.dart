class UesItemModel {
  final String message ; 
  final int targetId ; 


  const UesItemModel({required this.message , required this.targetId});

  factory UesItemModel.fromJson(Map <String , dynamic> json){
    return UesItemModel(message: json["message"]??"" , 
    targetId: json["data"]["target_id"]??0);
  }
}