import 'package:tik_chat_v2/features/profile/data/model/agency_member_model.dart';

class AgencyHistoryModle {
 final int? sumAgencyDaiomd ;
 final int? sumAgencyUsd ;
  final int? totalOwnerUsd ;
  List <AgencyMemberModel>? users ;

  AgencyHistoryModle({this.sumAgencyUsd , this.totalOwnerUsd, this.sumAgencyDaiomd , this.users});

 factory   AgencyHistoryModle.fromJson(Map<String , dynamic> json){
  return AgencyHistoryModle(sumAgencyDaiomd : json['sum']??0 , 
  sumAgencyUsd: json['sum_usd']??0,
  totalOwnerUsd: json['Total_owner_usd']??0,

  users:  List<AgencyMemberModel>.from(
          json['users'].map((x) => AgencyMemberModel.fromJson(x)))
  );
 }



}

