import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';


class SearchModel extends Equatable {
  final List<UserDataModel> userModel;
  final List<RoomModel> roomModel;

  const SearchModel({required this.userModel,required this.roomModel
  });

  factory SearchModel.fromJson(Map<String, dynamic> jsonData) {
    return SearchModel(
        userModel: List<UserDataModel>.from(
            jsonData['user'].map((e) => UserDataModel.fromMap(e))),
       roomModel: List<RoomModel>.from(
           jsonData['rooms'].map((e) => RoomModel.fromJson(e)))
    );
  }

  @override
  List<Object?> get props => [userModel, //roomModel
  ];
}

class RoomModel extends Equatable {
  final String roomName;
  final int uid;
  final int hot;
  final String roomCover;
  final String nickname;
  final String roomWelcome;
  final bool passwordStatus ; 

  const RoomModel(
      {required this.roomName,
      required this.uid,
      required this.hot,
      required this.roomCover,
      required this.nickname , required this.roomWelcome , required this.passwordStatus });

  factory RoomModel.fromJson(Map<String, dynamic> jsonData) {
    return RoomModel(
      roomWelcome: jsonData["room_welcome"]??"",
      roomCover: jsonData['room_cover'] ?? "",
      uid: jsonData['uid'],
      hot: jsonData['hot'],
      nickname: jsonData['nickname'] ?? "",
      roomName: jsonData['room_name'],
      passwordStatus: jsonData['room_pass']
    );
  }

  @override
  List<Object?> get props => [
        roomName,
        uid,
        hot,
        roomCover,
        nickname,
        roomWelcome

      ];
}

class UserModel extends Equatable {
  final String name;
  final String nickname;
  final int id;
  final int isFollow;
  final StoreModel storeModel;
  final String leng;
  final String gender;
  final String avatar;

  const UserModel(
      {required this.name,
      required this.nickname,
      required this.id,
      required this.isFollow,
      required this.storeModel,
      required this.leng,
      required this.gender,
      required this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        name: jsonData["name"],
        nickname: jsonData['nickname'],
        id: jsonData['id'],
        isFollow: jsonData['is_follow'],
        storeModel: StoreModel.fromJson(jsonData['my_store']),
        leng: jsonData['lang'],
        gender: jsonData['gender'],
        avatar: jsonData['avatar']);
  }

  @override
  List<Object?> get props => [
        nickname,
        id,
        isFollow,
        storeModel,
        leng,
        gender,
        avatar,
      ];
}

class StoreModel extends Equatable {
  final int id;
  final int diamonds;
  final int coins;
  final int roomCoins;
  final int gold;
  final int withdrawalCoins;
  final int coupons;

  const StoreModel(
      {required this.id,
      required this.diamonds,
      required this.coins,
      required this.roomCoins,
      required this.gold,
      required this.withdrawalCoins,
      required this.coupons});

  factory StoreModel.fromJson(Map<String, dynamic> jsonData) => StoreModel(
      id: jsonData['id'],
      diamonds: jsonData['diamonds'],
      coins: jsonData['coins'],
      roomCoins: jsonData['room_coins'],
      gold: jsonData['gold'],
      withdrawalCoins: jsonData['withdrawal_coins'],
      coupons: jsonData['coupons']);

  @override
  List<Object?> get props => [
        id,
        diamonds,
        coins,
        roomCoins,
        gold,
        withdrawalCoins,
        coupons,
      ];
}
