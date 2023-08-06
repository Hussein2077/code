import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class AgencyHistoryModle {
 final int? sum ; 
 final List <OwnerDataModel>? users ;

 const AgencyHistoryModle({this.sum , this.users});

 factory   AgencyHistoryModle.fromJson(Map<String , dynamic> json){
  return AgencyHistoryModle(sum : json['sum'] , 
  users:  List<OwnerDataModel>.from(
          json['users'].map((x) => OwnerDataModel.fromMap(x)))
  );
 }

}