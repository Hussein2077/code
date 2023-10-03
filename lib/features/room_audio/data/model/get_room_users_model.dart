import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';



class GetRoomUsersModel extends Equatable {
  final String rommId;
  final UserDataModel owner ;
  final List<UserDataModel> adminData;
 final List<UserDataModel> vistorsData;
  const GetRoomUsersModel(
      {required this.owner,
        required this.adminData,
        required this.rommId,
        required this.vistorsData});


  factory GetRoomUsersModel.fromjson(Map<String, dynamic> json) {
    return GetRoomUsersModel(
        owner: UserDataModel.fromMap( json['owner']) ,
        adminData: List<UserDataModel>.from((json["admin"] as List).map(
              (e) => UserDataModel.fromMap( e),
        )),
        rommId: json["room_id"],
        vistorsData: List<UserDataModel>.from((json["visitors"]).map(
              (e) => UserDataModel.fromMap(e),
        )));
  }

  @override
  // TODO: implement props
  List<Object?> get props => [rommId, adminData, vistorsData];
}
