

import 'package:tik_chat_v2/core/model/family_data_model.dart';
import 'package:tik_chat_v2/core/model/level_data_model.dart';
import 'package:tik_chat_v2/core/model/my_agency_model.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/my_store_model.dart';
import 'package:tik_chat_v2/core/model/now_room_model.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';

class UserDataModel {
  final int? id;
  final String? chatId ;
  final String? name;
  final bool? isFollow;
  final int? numberOfFans;
  final ProfileRoomModel? profile;
  final NowRoomModel? nowRoom;
  final LevelDataModel? level;
  final VipCenterModel? vip1;
  final MyStoreModel? myStore;
  final String? frame;
  final String? intro;
  final int? frameId;
  final int? introId;
  final int? bubbleId;
  final String? bubble;
  final MyAgencyModel? myAgencyModel;
  final bool? isAgencyRequest;
  final bool? isFriend;
  final bool? isFirst;
  final int? familyId;
  final FamilyDataModel? familyData;
  final String? uuid;
  final String? notificationId;
  final String? bio ;
  final bool? hasColorName ;
  final bool? isAanonymous ;
  final String? onlineTime;
  final bool? isCountryHiden ;
  final int? userType ;




  UserDataModel(
      {this.bubbleId,
        this.introId,
        this.hasColorName,
        this.onlineTime,
        this.frameId,
        this.isAanonymous,
        this.isFirst,
        this.id,
        this.chatId,
        this.isFollow,
        this.name,
        this.numberOfFans,
        this.profile,
        this.level,
        this.vip1,
        this.myStore,
        this.nowRoom,
        this.intro,
        this.frame,
        this.myAgencyModel,
        this.isAgencyRequest,
        this.familyId,
        this.familyData,
        this.uuid ,
        this.notificationId,
        this.isFriend,this.bio,
        this.bubble,
        this.isCountryHiden ,
        this.userType
      });




  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
        id: map['id'] ,
        chatId: map['chat_id'] ,
        notificationId: map['notification_id'],
        onlineTime: map['online_time'],
        name: map['name'] ,
        frame: map['frame'] ,
        intro: map['intro'] ,
        isFriend: map['is_friend'] ,
        bubbleId: map['bubble_id'] ,
        bubble: map['bubble'] ,
        frameId: map['frame_id'] ,
        introId: map['intro_id'] ,
        isFirst: map['is_first'],
        isAgencyRequest: map['is_agency_request'],
        isAanonymous :map['anonymous'],
        vip1:map['vip']==null?null: VipCenterModel.fromJson(map['vip']),
        familyId: map['family_id'],
        uuid: map['uuid'],
        isFollow: map['is_follow'] != null ? map['is_follow'] as bool : false,
        bio: map['bio'] != null ?map['bio'] as String :"",
        numberOfFans:
        map['number_of_fans'] ,
        profile: map['profile'] != null
            ? ProfileRoomModel.fromMap(map['profile'] as Map<String, dynamic>)
            : null,
        level: map['level'] != null
            ? LevelDataModel.fromMap(map['level'] as Map<String, dynamic>)
            : null,
        myStore: map['my_store'] != null
            ? MyStoreModel.fromMap(map['my_store'] as Map<String, dynamic>)
            : null,
        nowRoom: map['now_room'] != null
            ? NowRoomModel.fromjson(map["now_room"] as Map<String, dynamic>)
            : null,
        userType: map['type_user'],
        hasColorName: map['has_color_name'],
        isCountryHiden: map['country_hidden'],
        familyData: map['family_data']==null? null:  FamilyDataModel.fromjosn(
            map['family_data']),
        myAgencyModel: map['agency'] != null
            ? MyAgencyModel.fromjson(map["agency"])
            : null);

  }


  MyDataModel convertToMyDataObject() {
    return MyDataModel(
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
        gender: profile?.gender??1,
        age: profile?.age??0,
        country: profile?.country

      ),
      name: name,
      chatId: chatId,
      hasColorName: hasColorName,
      notificationId: notificationId,
      level: LevelDataModel(senderImage: level?.senderImage,
          receiverImage: level?.receiverImage),
      vip1: VipCenterModel(level: vip1?.level),
      myType: userType
    );

  }







}