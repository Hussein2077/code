// ignore_for_file: unnecessary_question_mark

import 'dart:convert';
import 'dart:developer';


import 'package:tik_chat_v2/core/model/family_data_model.dart';
import 'package:tik_chat_v2/core/model/level_data_model.dart';
import 'package:tik_chat_v2/core/model/my_agency_model.dart';
import 'package:tik_chat_v2/core/model/my_store_model.dart';
import 'package:tik_chat_v2/core/model/now_room_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';

import 'profile_room_model.dart';
import 'vip_center_model.dart';


class OwnerDataModel {
  final int? id;
  final String? chatId ;
  final String? name;
  final String? email;
  final dynamic? phone;
  final bool? isFollow;
  final int? numberOfFans;
  final int? numberOfFollowings;
  final int? numberOfFriends;
  final int? profileVisotrs;
  final ProfileRoomModel? profile;
  final NowRoomModel? nowRoom;
  final LevelDataModel? level;
  final VipCenterModel? vip1;
 // final IncomeDataModle? income;
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

  final String? visitTime ;
  final bool? isFriend;
  final bool? isFirst;
  final int? familyId;
  final FamilyDataModel? familyData;
  final String? uuid;
  final String? notificationId;
  final String? bio ;
  final bool? hasRoom ;
  final bool? hasColorName ;
  final bool? isHideRoom ;
  final bool? isAanonymous ;
  final int? numPobUp ;
  final String? onlineTime;
    final bool? isCountryHiden ;
    final String? groupMessage ; 
    final String? massageCreatedAt ;
  final bool? isFacebook ;
  final bool? isGoogle ;
  final bool? isPhone ;



  OwnerDataModel(
      {this.bubbleId,
      this.introId,
        this.numPobUp,
      this.hasColorName,
     this.onlineTime,
      this.frameId,
     this.isAanonymous,
      this.isFirst,
      this.hasRoom,
      this.profileVisotrs,
      this.id,
      this.chatId,
      this.isFollow,
      this.name,
      this.email,
      this.phone,
      this.numberOfFans,
      this.numberOfFollowings,
      this.numberOfFriends,
      this.profile,
      this.level,
      this.visitTime,
      this.vip1,
      //this.income,
      this.myStore,
      this.authToken,
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
      this.isHideRoom,
        this.isCountryHiden ,
        this.groupMessage , 
        this.massageCreatedAt,
        this.isFacebook,
        this.isGoogle,
        this.isPhone,
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
      //'income': income?.toMap(),
      'my_store': myStore?.toMap(),
      ConstentApi.authToken: authToken
    };
  }

  factory OwnerDataModel.fromMap(Map<String, dynamic> map) {
    log("map['family_data']${map['family_data']}");
    return OwnerDataModel(
        id: map['id'] != null ? map['id'] as int : null,
        chatId: map['chat_id'] ,
        notificationId: map['notification_id'],
        numPobUp: map['wapel_num'],
        onlineTime: map['online_time'],
        name: map['name'] != null ? map['name'] as String : null,
        email: map['email'] != null ? map['email'] as String : null,
        phone: map['phone'] != null ? map['phone'] as dynamic : null,
        frame: map['frame'] != null ? map['frame'] as String : null,
        intro: map['intro'] != null ? map['intro'] as String : null,
        isFriend: map['is_friend'] != null ? map['is_friend'] as bool : null,
        visitTime: map['visit_time'],
        bubbleId: map['bubble_id'] != null ? map['bubble_id'] as int : 0,
        bubble: map['bubble'],
        frameId: map['frame_id'] != null ? map['frame_id'] as int : 0,
        introId: map['intro_id'] != null ? map['intro_id'] as int : 0,
        isFirst: map['is_first'],
        isAgencyRequest: map['is_agency_request'],
        hasRoom: map['has_room'],
        isHideRoom: map['room_hidden'],
        isAanonymous :map['anonymous'],
        isFacebook:map['facebook_bind'],
        isGoogle:map['google_bind'],
        isPhone:map['phone_bind'],
        vip1:map['vip']==null?null: VipCenterModel.fromJson(map['vip']),
        familyId: map['family_id'],
        uuid: map['uuid'] != null ? map['uuid'] as String : "0",
        isFollow: map['is_follow'] != null ? map['is_follow'] as bool : false,
         bio: map['bio'] != null ?map['bio'] as String :"",
         groupMessage:  map['group_message'] != null ?map['group_message'] as String :"",
         massageCreatedAt:  map['created_at'] != null ?map['created_at'] as String :"",
         
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
        // income: map['income'] != null
        //     ? IncomeDataModle.fromMap(map['income'] as Map<String, dynamic>)
        //     : null,
        myStore: map['my_store'] != null
            ? MyStoreModel.fromMap(map['my_store'] as Map<String, dynamic>)
            : null,
        nowRoom: map['now_room'] != null
            ? NowRoomModel.fromjson(map["now_room"] as Map<String, dynamic>)
            : null,
        hasColorName: map['has_color_name'],
        isCountryHiden: map['country_hidden'],
        familyData: map['family_data']==null? null:  FamilyDataModel.fromjosn(
            map['family_data']),
        myAgencyModel: map['agency'] != null
            ? MyAgencyModel.fromjson(map["agency"])
            : null);

  }

  String toJson() => json.encode(toMap());







}