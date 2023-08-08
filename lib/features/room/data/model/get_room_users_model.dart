import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';



class GetRoomUsersModel extends Equatable {
  final String rommId;
  final OwnerDataModel owner ;
  final List<OwnerDataModel> adminData;
 final List<OwnerDataModel> vistorsData;
  const GetRoomUsersModel(
      {required this.owner,
        required this.adminData,
        required this.rommId,
        required this.vistorsData});


  factory GetRoomUsersModel.fromjson(Map<String, dynamic> json) {
    return GetRoomUsersModel(
        owner: OwnerDataModel.fromMap( json['owner']) ,
        adminData: List<OwnerDataModel>.from((json["admin"] as List).map(
              (e) => OwnerDataModel.fromMap( e),
        )),
        rommId: json["room_id"],
        vistorsData: List<OwnerDataModel>.from((json["visitors"]).map(
              (e) => OwnerDataModel.fromMap(e),
        )));
  }

  @override
  // TODO: implement props
  List<Object?> get props => [rommId, adminData, vistorsData];
}
