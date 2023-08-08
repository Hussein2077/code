

//todo is_gold remove
//todo remove neck name
//todo  delete some data from faimly
//todo defeferce btw visit_time and online_time
//todo deference btw 2 diamons

import 'package:tik_chat_v2/core/model/family_data_model.dart';
import 'package:tik_chat_v2/core/model/level_data_model.dart';
import 'package:tik_chat_v2/core/model/my_agency_model.dart';
import 'package:tik_chat_v2/core/model/my_store_model.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';


class MyDataModel {
  final int? id;
  final String? chatId;
  final String? name;
  final String? email;
  final dynamic phone;
  final int? numberOfFans;
  final int? numberOfFollowings;
  final int? numberOfFriends;
  final int? profileVisotrs;
  final ProfileRoomModel? profile;
 // final NowRoomModel? nowRoom; //todo discussed
  final LevelDataModel? level;
  final VipCenterModel? vip1;
  final MyStoreModel? myStore;
  final String? authToken;
  final String? frame;
  final String? intro;
  final int? frameId;
  final int? introId;
  final int? bubbleId;
  final String? bubble;
  final MyAgencyModel? myAgencyModel;
  final bool? isAgencyRequest;
  final bool? isFirst;
  final int? familyId;
  final FamilyDataModel? familyData; //todo remove some att. from response
  final String? uuid;
  final String? notificationId;
  final String? bio;
  final bool? hasRoom;
  //final bool? hasColorName;////todo discussed
  //final bool? isHideRoom;//todo discussed
  final bool? isAanonymous;
  //final int? numPobUp;//todo discussed
  //final String? onlineTime; //todo discussed
  //final bool? isCountryHiden; //todo discussed
  final bool? isFacebook;
  final bool? isGoogle;
  final bool? isPhone;
  final int? diamonds;


  MyDataModel({
    this.isFirst,
    this.bubbleId,
    this.introId,
    this.frameId,
    this.isAanonymous,
    this.hasRoom,
    this.profileVisotrs,
    this.id,
    this.chatId,
    this.name,
    this.email,
    this.phone,
    this.numberOfFans,
    this.numberOfFollowings,
    this.numberOfFriends,
    this.profile,
    this.level,
    this.vip1,
    this.myStore,
    this.authToken,
    this.intro,
    this.frame,
    this.myAgencyModel,
    this.isAgencyRequest,
    this.familyId,
    this.familyData,
    this.uuid,
    this.notificationId,
    this.bio,
    this.bubble,
    this.isFacebook,
    this.isGoogle,
    this.isPhone,
    this.diamonds
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'number_of_fans': numberOfFans,
      'number_of_followings': numberOfFollowings,
      'number_of_friends': numberOfFriends,
      'profile': profile?.toMap(),
      'level': level?.toMap(),
      'my_store': myStore?.toMap(),
      ConstentApi.authToken: authToken
    };
  }

  factory MyDataModel.fromJson(Map<String, dynamic> map) {
    return MyDataModel(
        id: map['id'] != null ? map['id'] as int : null,
        chatId: map['chat_id'],
        notificationId: map['notification_id'],
        name: map['name'] != null ? map['name'] as String : null,
        email: map['email'] != null ? map['email'] as String : null,
        phone: map['phone'] != null ? map['phone'] as dynamic : null,
        frame: map['frame'] != null ? map['frame'] as String : null,
        intro: map['intro'] != null ? map['intro'] as String : null,
        bubbleId: map['bubble_id'] != null ? map['bubble_id'] as int : 0,
        bubble: map['bubble'],
        frameId: map['frame_id'] != null ? map['frame_id'] as int : 0,
        introId: map['intro_id'] != null ? map['intro_id'] as int : 0,
        isFirst: map['is_first'],
        isAgencyRequest: map['is_agency_request'],
        hasRoom: map['has_room'],
        isAanonymous: map['anonymous'],
        isFacebook: map['facebook_bind'],
        isGoogle: map['google_bind'],
        isPhone: map['phone_bind'],
        vip1: map['vip'] == null ? null : VipCenterModel.fromJson(map['vip']),
        familyId: map['family_id'],
        uuid: map['uuid'] != null ? map['uuid'] as String : "0",
        bio: map['bio'] != null ? map['bio'] as String : "",
        authToken: map[ConstentApi.authToken] != null
            ? map[ConstentApi.authToken] as String
            : null,
        numberOfFans:
        map['number_of_fans'] != null ? map['number_of_fans'] as int : null,
        numberOfFollowings: map['number_of_followings'] != null
            ? map['number_of_followings'] as int
            : null,
        numberOfFriends: map['number_of_friends'] != null
            ? map['number_of_friends'] as int
            : null,
        profileVisotrs: map['profile_visitors'] != null
            ? map['profile_visitors'] as int
            : null,
        profile: map['profile'] != null
            ? ProfileRoomModel.fromMap(map['profile'] as Map<String, dynamic>)
            : null,
        level: map['level'] != null
            ? LevelDataModel.fromMap(map['level'] as Map<String, dynamic>)
            : null,
        myStore: map['my_store'] != null
            ? MyStoreModel.fromMap(map['my_store'] as Map<String, dynamic>)
            : null,
        familyData: map['family_data'] == null
            ? null
            : FamilyDataModel.fromjosn(map['family_data']),
        myAgencyModel: map['agency'] != null
            ? MyAgencyModel.fromjson(map["agency"])
            : null,
        diamonds: map["diamonds"]
    );
  }
}