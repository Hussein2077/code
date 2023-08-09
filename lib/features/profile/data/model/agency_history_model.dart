import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class AgencyHistoryModle {
 final int? sumAgencyDaiomd ;
 final int? sumAgencyUsd ;
  final int? totalOwnerUsd ;
  List <UserDataModel>? users ;

  AgencyHistoryModle({this.sumAgencyUsd , this.totalOwnerUsd, this.sumAgencyDaiomd , this.users});

 factory   AgencyHistoryModle.fromJson(Map<String , dynamic> json){
  return AgencyHistoryModle(sumAgencyDaiomd : json['sum']??0 , 
  sumAgencyUsd: json['sum_usd']??0,
  totalOwnerUsd: json['Total_owner_usd']??0,

  users:  List<UserDataModel>.from(
          json['users'].map((x) => UserDataModel.fromMap(x)))
  );
 }

}