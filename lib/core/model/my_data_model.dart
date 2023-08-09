//todo is_gold remove
//todo remove neck name
//todo  delete some data from faimly
//todo deference btw visit_time and online_time
//todo deference btw 2 diamonds


import 'package:tik_chat_v2/core/model/level_data_model.dart';
import 'package:tik_chat_v2/core/model/my_agency_model.dart';
import 'package:tik_chat_v2/core/model/my_store_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
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
  final String? uuid;
  final String? notificationId;
  final String? bio;
  final bool? hasRoom;
  final bool? hasColorName;
  final bool? isAanonymous;
  final int? numPobUp;
  final bool? isFacebook;
  final bool? isGoogle;
  final bool? isPhone;
  final int? myType;


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
    this.uuid,
    this.notificationId,
    this.bio,
    this.bubble,
    this.isFacebook,
    this.isGoogle,
    this.isPhone,
    this.hasColorName,
    this.numPobUp,
    this.myType
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

  factory MyDataModel.fromMap(Map<String, dynamic> map) {
    return MyDataModel(
      id: map['id'] ,
      chatId: map['chat_id'],
      notificationId: map['notification_id'],
      name: map['name'] ,
      email: map['email'] ,
      phone: map['phone'] ,
      frame: map['frame'] ,
      intro: map['intro'] ,
      bubbleId: map['bubble_id'] ,
      bubble: map['bubble'],
      myType:map['type_user'],
      hasColorName: map['has_color_name'],
      frameId: map['frame_id'] ,
      introId: map['intro_id'] ,
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
      authToken: map[ConstentApi.authToken],
      numberOfFans: map['number_of_fans'] ,
      numberOfFollowings: map['number_of_followings'] ,
      numberOfFriends: map['number_of_friends'],
      profileVisotrs: map['profile_visitors'],
      profile: map['profile'] != null
          ? ProfileRoomModel.fromMap(map['profile'] as Map<String, dynamic>)
          : null,
      level: map['level'] != null
          ? LevelDataModel.fromMap(map['level'] as Map<String, dynamic>)
          : null,
      myStore: map['my_store'] != null
          ? MyStoreModel.fromMap(map['my_store'] as Map<String, dynamic>)
          : null,
      numPobUp: map['wapel_num'], // todo update that
      myAgencyModel: map['agency'] != null
          ? MyAgencyModel.fromjson(map["agency"])
          : null,


    );
  }

  UserDataModel convertToUserObject() {
    return UserDataModel(
      id: id,
      bubble:bubble,
      bubbleId:bubbleId,
      intro:intro,
      introId:introId,
      frame: frame,
      familyId: familyId,
      frameId: familyId,
      uuid:uuid,
      profile: ProfileRoomModel(
        image:profile?.image??'',
        gender: profile?.gender??'male',
        age: profile?.age??0,
        country: profile?.country,



      ),
      name: name,
      chatId: chatId,
      hasColorName: hasColorName,
      notificationId: notificationId,
      level: LevelDataModel(senderImage: level?.senderImage,
          receiverImage: level?.receiverImage),
      vip1: VipCenterModel(level: vip1?.level),
      userType: myType
    );

  }

}